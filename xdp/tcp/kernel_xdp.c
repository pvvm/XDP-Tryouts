/* SPDX-License-Identifier: GPL-2.0 */

#include <linux/bpf.h>

#include <linux/in.h>

#include <linux/if_ether.h>

#include <time.h>
#include <stdlib.h>
#include <math.h>

#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
#include "../common/parsing_helpers.h"
#include "../common/rewrite_helpers.h"

#include "common_def.h"

#define ONE_SEC 1000000000 


// From benchmark: to remove later
struct info {
    __u64 latency;
    __u64 counter;
};

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct info);
    __uint(max_entries, MAX_NUMBER_CORES);
} info_array SEC(".maps");


/*--------------- XSK MAP ---------------*/

struct {
    __uint(type, BPF_MAP_TYPE_XSKMAP);
    __type(key, __u32);
    __type(value, __u32);
    __uint(max_entries, MAX_NUMBER_CORES);
} xsks_map SEC(".maps");

/*--------------- APP EVENT MAPS ---------------*/

struct inner_app_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct app_event); 
    __uint(max_entries, MAX_EVENT_QUEUE_LEN);
} inner_app_array SEC(".maps");

struct outer_app_hash {
    __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
    __type(key, __u32);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
    __array(values, struct inner_app_array);
} outer_app_array SEC(".maps") = {
    .values = {(void*)&inner_app_array},
};

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, __u32);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
} tail_app_array SEC(".maps");

/*--------------- TIMER EVENT MAPS ---------------*/

struct inner_timer_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct timer_event);
    __uint(max_entries, MAX_EVENT_QUEUE_LEN);
} inner_timer_array SEC(".maps");

struct outer_timer_hash {
    __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
    __type(key, __u32);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
    __array(values, struct inner_timer_array);
} outer_timer_array SEC(".maps") = {
    .values = {(void*)&inner_timer_array},
};


/*--------------- PROG EVENT MAPS ---------------*/

struct inner_prog_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct prog_event);
    __uint(max_entries, MAX_EVENT_QUEUE_LEN);
} inner_prog_array SEC(".maps");

struct outer_prog_hash {
    __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
    __type(key, __u32);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
    __array(values, struct inner_prog_array);
} outer_prog_array SEC(".maps") = {
    .values = {(void*)&inner_prog_array},
};

/*--------------- FLOW ID HASH MAP ---------------*/

struct flow_id_hash {
    __uint(type, BPF_MAP_TYPE_HASH);
    __type(key, struct flow_id);
    __type(value, __u32);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
} flow_id_hash SEC(".maps");

/*--------------- FLOW INFO MAPS ---------------*/

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct queue_flow_info);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
} queue_flow_info_array SEC(".maps");

/*--------------- TIMER TRIGGER MAP ---------------*/

struct {
    __uint(type, BPF_MAP_TYPE_HASH);
    __type(key, struct timer_trigger_id);
    __type(value, struct timer_trigger);
    __uint(max_entries, (MAX_NUMBER_FLOWS + 1) * MAX_NUMBER_TIMERS);
} timer_trigger_hash SEC(".maps");


/*--------------- CONTEXT ARRAY MAP ---------------*/

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct context);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
} context_array SEC(".maps");


static __always_inline int initialize_timer(struct timer_event, __u64, enum timer_id);

static __always_inline __u32 * retrieve_flow_array_id(struct flow_id flow_hash_id) {
    __u32 * flow_array_id = bpf_map_lookup_elem(&flow_id_hash, &flow_hash_id);
    if(!flow_array_id) {
        bpf_printk("retrieve_flow_array_id: flow_array_id wasn't correctly set");
        return NULL;
    }
    return flow_array_id;
}

static __always_inline __u8 define_minor_type(struct net_event net_ev[MAX_NET_EVENTS], __u16 ack_pkt, __u32 data_len) {
    if(ack_pkt && data_len > 0) {
        net_ev[0].event_type = DATA;
        net_ev[1].ev_flow_id = net_ev[0].ev_flow_id;
        net_ev[1].data_len = net_ev[0].data_len;
        net_ev[1].ack_seq = net_ev[0].ack_seq;
        net_ev[1].seq_num = net_ev[0].seq_num;
        net_ev[1].rwnd_size = net_ev[0].rwnd_size;
        net_ev[1].event_type = ACK;
        return 2;
    } else if(ack_pkt && data_len == 0)
        net_ev[0].event_type = ACK;
    else if(!ack_pkt)
        net_ev[0].event_type = DATA;
    return 1;
}

static __always_inline __u8 parse_packet(void *data, void *data_end,
    struct net_event net_ev[MAX_NET_EVENTS], struct metadata_hdr *meta_hdr) {
    struct ethhdr *eth;
    struct iphdr *iphdr;
    struct tcphdr *tcph;

    struct hdr_cursor nh;
    int eth_type, ip_type;

    nh.pos = data;

    eth_type = parse_ethhdr(&nh, data_end, &eth);
    if (eth_type != bpf_htons(ETH_P_IP)) {
        //bpf_printk("parse_packet: error while parsing ETH header");
        return 0;
    }

    ip_type = parse_iphdr(&nh, data_end, &iphdr);
    if(ip_type != IPPROTO_TCP) {
        //bpf_printk("parse_packet: error while parsing IP header");
        return 0;
    }

    struct flow_id flow_hash_id;
    flow_hash_id.src_ip = iphdr->saddr;
    flow_hash_id.dest_ip = iphdr->daddr;

    if(parse_tcphdr(&nh, data_end, &tcph) ==  -1) {
        //bpf_printk("parse_packet: error while parsing TCP header");
        return 0;
    }

    flow_hash_id.src_port = bpf_ntohs(tcph->source);
    flow_hash_id.dest_port = bpf_ntohs(tcph->dest);


    ////bpf_printk("\nACK: %d %d\n", tcph->ack, bpf_ntohl(tcph->ack_seq));
    ////bpf_printk("%d %d", net_ev->ev_flow_id.src_ip, net_ev->ev_flow_id.dest_ip);
    ////bpf_printk("%d %d", net_ev->ev_flow_id.src_port, net_ev->ev_flow_id.dest_port);

    __u32 * flow_array_id = retrieve_flow_array_id(flow_hash_id);
    if(!flow_array_id)
        return 0;
    net_ev[0].ev_flow_id = *flow_array_id;
    net_ev[0].seq_num = bpf_ntohl(tcph->seq);
    net_ev[0].ack_seq = bpf_ntohl(tcph->ack_seq);
    net_ev[0].data_len = bpf_ntohs(iphdr->tot_len) - sizeof(struct iphdr) - sizeof(struct tcphdr);
    net_ev[0].rwnd_size = bpf_ntohs(tcph->window);
    __u8 ret = define_minor_type(net_ev, tcph->ack, net_ev[0].data_len);

    __builtin_memcpy(meta_hdr->src_mac, eth->h_source, ETH_ALEN);
    __builtin_memcpy(meta_hdr->dst_mac, eth->h_dest, ETH_ALEN);
    meta_hdr->src_ip = iphdr->saddr;
    meta_hdr->dst_ip = iphdr->daddr;
    meta_hdr->src_port = tcph->source;
    meta_hdr->dst_port = tcph->dest;



    // Note: identifies if it is a bpf_prog_run packet via IP header ID
    if(iphdr->id == 65535) {
        ret = 3;
    }

    return ret;
}

static __always_inline __u8 mutate_pkt(struct xdp_md *redirect_pkt, struct net_event net_ev[MAX_NET_EVENTS]) {

    void *data_end = (void *)(long)redirect_pkt->data_end;
    void *data     = (void *)(long)redirect_pkt->data;

    __u32 pkt_len = data_end - data;

    __u32 original_header_len = sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct tcphdr);

    __u32 new_header_len = sizeof(struct metadata_hdr);

    struct metadata_hdr new_hdr;
    new_hdr.data_len = pkt_len - original_header_len;

    __u8 ret = parse_packet(data, data_end, net_ev, &new_hdr);
    if(!ret)
        return 0;

    bpf_xdp_adjust_head(redirect_pkt, original_header_len - new_header_len);

    data_end = (void *)(long)redirect_pkt->data_end;
    data     = (void *)(long)redirect_pkt->data;
    pkt_len = data_end - data;

    new_hdr.metadata_end = pkt_len;

    if(data + sizeof(new_hdr) > data_end)
        return 0;

    __builtin_memcpy(data, &new_hdr, sizeof(new_hdr));

    bpf_xdp_adjust_tail(redirect_pkt, MUTATED_PACKET_SIZE);

    return ret;
}

static __always_inline struct context * retrieve_ctx(__u32 f_id) {
    struct context *ctx = bpf_map_lookup_elem(&context_array, &f_id);
    if(!ctx) {
        bpf_printk("retrieve_ctx: context map entry wasn't set");
        return NULL;
    }
    return ctx;
}

static __always_inline void update_app_len(struct app_info *app_info, __u32 f_id) {

    __u32 *app_tail = bpf_map_lookup_elem(&tail_app_array, &f_id);
    if(!app_tail) {
        bpf_printk("update_app_len: app tail map entry wasn't set");
        __u32 new_tail = 0;
        bpf_map_update_elem(&tail_app_array, &f_id, &new_tail, BPF_NOEXIST);
        app_tail = bpf_map_lookup_elem(&tail_app_array, &f_id);
        if(!app_tail) {
            //bpf_printk("update_app_len: couldn't get entry from app tail map");
            return;
        }
    }
    app_info->app_tail = *app_tail;
    app_info->len_app_queue = (app_info->app_tail - app_info->app_head + MAX_EVENT_QUEUE_LEN) % MAX_EVENT_QUEUE_LEN;
}


static __always_inline struct queue_flow_info * find_queue_flow_info(__u32 f_id) {

    struct queue_flow_info *f_info = bpf_map_lookup_elem(&queue_flow_info_array, &f_id);
    if(!f_info) {
        struct queue_flow_info new_f_info = {{0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0}};
        bpf_map_update_elem(&queue_flow_info_array, &f_id, &new_f_info, BPF_NOEXIST);
        f_info = bpf_map_lookup_elem(&queue_flow_info_array, &f_id);
        if(!f_info) {
            //bpf_printk("find_queue_flow_info: Couldn't get entry from flow info inner map");
            return NULL;
        }
        return f_info;
    }
    return f_info;
}

static __always_inline int try_to_enqueue(void * map, void * event,
    __u32 f_id, int * queue_len, int *tail) {

    if(*queue_len == MAX_EVENT_QUEUE_LEN - 1) {
        //bpf_printk("Queue is full: unable to enqueue event");
        return 0;
    }

    void *inner_array = bpf_map_lookup_elem(map, &f_id);
    if(!inner_array) {
        //bpf_printk("try_to_enqueue: Couldn't get entry from outer map");
        return 0;
    }

    if(bpf_map_update_elem(inner_array, tail, event, BPF_ANY)) {
        //bpf_printk("try_to_enqueue: Couldn't update entry from inner map");
        return 0;
    }

    if(*tail < MAX_EVENT_QUEUE_LEN - 1)
        *tail += 1;
    else
        *tail = 0;
    
    *queue_len += 1;
    
    return 1;
}

static __always_inline void generic_event_enqueue(void * event, enum major_event_type type) {
    switch (type)
    {
    case PROG_EVENT:
    {
        //bpf_printk("PROG_EVENT");
        struct prog_event enq_event = *(struct prog_event *) event;
        struct queue_flow_info *f_info = find_queue_flow_info(enq_event.ev_flow_id);
        if(!f_info)
            return;
        if(!try_to_enqueue(&outer_prog_array, event, enq_event.ev_flow_id, &(f_info->prog_info.len_prog_queue),
            &(f_info->prog_info.prog_tail))) {
            //bpf_printk("Unable to enqueue PROG_EVENT");
        }
        break;
    }
    
    default:
        return;
    }
}

static __always_inline int next_event(struct queue_flow_info * f_info) {
    // App, net, timer, prog. App has the lowest priority, timer has the highest
    __u32 type_priorities[3] = {1, 3, 2};
    type_priorities[0] *= f_info->app_info.len_app_queue;
    type_priorities[1] *= f_info->timer_info.len_timer_queue;
    type_priorities[2] *= f_info->prog_info.len_prog_queue;

    //bpf_printk("APP: %d", type_priorities[0]);
    //bpf_printk("TIMER: %d PROG: %d", type_priorities[1], type_priorities[2]);
    //bpf_printk("\nLen timer: %d",  f_info->timer_info.len_timer_queue);

    __u32 sum = type_priorities[0] + type_priorities[1] + type_priorities[2];
    if(sum == 0)
        return -1;

    __u32 max_prio = 0;
    int type = 0;
    for(int i = 0; i < 3; i++) {
        if(type_priorities[i] > max_prio) {
            max_prio = type_priorities[i];
            type = i;
        }
    }

    return type;
}

static __always_inline void * timer_event_dequeue(__u32 f_id,
    __u64 * queue_len, int * head) {
    if(__sync_fetch_and_or(queue_len, 0) == 0) {
        bpf_printk("timer_event_dequeue: queue is empty, unable to dequeue an event");
        return NULL;
    }
    
    void * inner_flow_array = bpf_map_lookup_elem(&outer_timer_array, &f_id);
    //void * inner_flow_array = bpf_map_lookup_elem(outer_event_hash, &f_id);
    if(!inner_flow_array) {
        bpf_printk("event_dequeue: Couldn't get entry from flow info outer map");
        return NULL;
    }

    struct timer_event * event = (struct timer_event *) bpf_map_lookup_elem(inner_flow_array, head);
    if(!event) {
        bpf_printk("event_dequeue: Couldn't get entry from flow info inner map");
        return NULL;
    }

    if(__sync_fetch_and_or(&event->valid_bit, 0)) {
        if(*head < MAX_EVENT_QUEUE_LEN - 1)
            *head += 1;
        else
            *head = 0;
        
        __sync_fetch_and_add(queue_len, -1);

        __sync_fetch_and_xor(&event->valid_bit, 1);

        return event;
    } else {
        bpf_printk("timer_event_dequeue: couldn't dequeue because event is invalid");
    }
    return NULL;
}

static __always_inline struct prog_event * prog_event_dequeue(__u32 f_id,
    int * queue_len, int * head) {
    if(*queue_len == 0) {
        bpf_printk("prog_event_dequeue: queue is empty, unable to dequeue an event");
        return NULL;
    }
    
    void * inner_flow_array = bpf_map_lookup_elem(&outer_prog_array, &f_id);
    if(!inner_flow_array) {
        bpf_printk("event_dequeue: couldn't get entry from flow info outer map");
        return NULL;
    }

    struct prog_event * event = bpf_map_lookup_elem(inner_flow_array, head);
    if(!event) {
        bpf_printk("event_dequeue: couldn't get entry from flow info inner map");
        return NULL;
    }

    if(*head < MAX_EVENT_QUEUE_LEN - 1)
        *head += 1;
    else
        *head = 0;
    
    *queue_len -= 1;

    return event;
}

static __always_inline struct app_event * app_event_dequeue(__u32 f_id,
    int * queue_len, int * head) {
    if(*queue_len == 0) {
        bpf_printk("prog_event_dequeue: queue is empty, unable to dequeue an event");
        return NULL;
    }
    
    void * inner_flow_array = bpf_map_lookup_elem(&outer_app_array, &f_id);
    if(!inner_flow_array) {
        bpf_printk("event_dequeue: couldn't get entry from flow info outer map");
        return NULL;
    }

    struct app_event * event = bpf_map_lookup_elem(inner_flow_array, head);
    if(!event) {
        bpf_printk("event_dequeue: couldn't get entry from flow info inner map");
        return NULL;
    }

    if(*head < MAX_EVENT_QUEUE_LEN - 1)
        *head += 1;
    else
        *head = 0;
    
    *queue_len -= 1;

    return event;
}

static __always_inline int timer_event_enqueue(void *map, __u32 *f_id, struct timer_trigger *val) {
    struct timer_event event = val->t_event;
    event.valid_bit = 1;

    //bpf_printk("TIMER_EVENT");
    struct queue_flow_info *f_info = find_queue_flow_info(event.ev_flow_id);
    if(!f_info)
        return 0;
    __u64 * executing = &f_info->timer_info.executing_enqueue;
    __u64 * queue_len = &f_info->timer_info.len_timer_queue;
    __u32 * tail = &f_info->timer_info.timer_tail;

    if(__sync_fetch_and_or(executing, 0)) {
        bpf_printk("try_to_enqueue_timer: timer enqueue currently executing");
        bpf_timer_start(&val->timer, ONE_SEC, 0);
        return 0;
    }
    val->triggered = 0;

    // Set executing bit to 1
    __sync_fetch_and_xor(executing, 1);

    if(__sync_fetch_and_or(queue_len, 0) == MAX_EVENT_QUEUE_LEN - 1) {
        bpf_printk("try_to_enqueue_timer: queue is full, unable to enqueue event");
        __sync_fetch_and_xor(executing, 1);
        return 0;
    }

    struct inner_timer_array *inner_array = bpf_map_lookup_elem(&outer_timer_array, &event.ev_flow_id);
    if(!inner_array) {
        bpf_printk("try_to_enqueue_timer: couldn't get entry from outer map");
        __sync_fetch_and_xor(executing, 1);
        return 0;
    }

    if(bpf_map_update_elem(inner_array, tail, &event, BPF_ANY)) {
        bpf_printk("try_to_enqueue_timer: couldn't update entry from inner map");
        __sync_fetch_and_xor(executing, 1);
        return 0;
    }

    if(*tail < MAX_EVENT_QUEUE_LEN - 1)
        *tail += 1;
    else
        *tail = 0;
    
    __sync_fetch_and_add(queue_len, 1);

    __sync_fetch_and_xor(executing, 1);
    
    return 0;
}

static __always_inline int cancel_timer(__u32 f_id, enum timer_id index) {

    struct timer_trigger_id timer_id = {f_id, index};
    struct timer_trigger *map_entry = bpf_map_lookup_elem(&timer_trigger_hash, &timer_id);
    if(!map_entry) {
        //bpf_printk("cancel_timer: Couldn't find inner map entry");
        return -1;
    }

    if(!map_entry->triggered) {
        //bpf_printk("cancel_timer: timer isn't currently triggered");
        return -1;
    }

    if(!bpf_timer_cancel(&(map_entry->timer))) {
        //bpf_printk("\n%d %d", f_id.src_port, f_id.dest_port);
        //bpf_printk("cancel_timer: couldn't cancel timer");
        return -1;
    }
    map_entry->triggered = 0;

    return 0;
}

static __always_inline int restart_timer(__u32 f_id, __u64 time,
    enum timer_id index) {

    struct timer_trigger_id timer_id = {f_id, index};
    struct timer_trigger *map_entry = bpf_map_lookup_elem(&timer_trigger_hash, &timer_id);
    if(!map_entry) {
        bpf_printk("restart_timer: Couldn't find inner map entry");
        return -1;
    }

    /*if(!map_entry->triggered) {
        //bpf_printk("restart_timer: timer isn't currently triggered");
        return -1;
    }*/

    map_entry->triggered = 1;

    if(bpf_timer_start(&(map_entry->timer), time, 0) != 0) {
        bpf_printk("restart_timer: couldn't restart timer");
        return -1;
    }

    return 0;
}

static __always_inline struct timer_trigger *retrieve_timer(__u32 f_id, enum timer_id index) {
    struct timer_trigger_id timer_id = {f_id, index};
    struct timer_trigger *map_entry = bpf_map_lookup_elem(&timer_trigger_hash, &timer_id);
    if(!map_entry) {
        struct timer_trigger new_entry;
        new_entry.triggered = 0;
        bpf_map_update_elem(&timer_trigger_hash, &timer_id, &new_entry, BPF_NOEXIST);
        map_entry = bpf_map_lookup_elem(&timer_trigger_hash, &timer_id);
        if(!map_entry) {
            bpf_printk("retrieve_timer: Couldn't find inner map entry");
            return NULL;
        }
        return map_entry;
    }
    return map_entry;
}

static __always_inline int initialize_timer(struct timer_event event,
    __u64 time, enum timer_id index) {

    struct timer_trigger *map_entry = retrieve_timer(event.ev_flow_id, index);
    if(!map_entry) {
        bpf_printk("initialize_timer: Couldn't find timer map entry");
        return -1;
    }

    if(map_entry->triggered) {
        //bpf_printk("initialize_timer: timer already triggered");
        return -1;
    }

    map_entry->t_event = event;
    map_entry->triggered = 1;

    long int err = bpf_timer_init(&(map_entry->timer), &timer_trigger_hash, CLOCK_BOOTTIME);
    /*if(err != 0) {
        bpf_printk("Error while initializing timer: %ld", err);
    }*/

    // Sets the function to be called after the timer triggers
    err = bpf_timer_set_callback(&(map_entry->timer), timer_event_enqueue);
    if(err != 0) {
        bpf_printk("Error while setting callback: %ld", err);
    }

    err = bpf_timer_start(&(map_entry->timer), time, 0);
    if(err != 0) {
        bpf_printk("Error while starting timer: %ld", err);
    }

    return 0;
}

static long send_n_packets(__u32 index, struct send_loop_args *arg) {

    int pkt_data_len;
    if(arg->bytes_to_send <= SMSS) {
        pkt_data_len = arg->bytes_to_send;
        arg->bytes_to_send = 0;
    } else {
        pkt_data_len = SMSS;
        arg->bytes_to_send -= SMSS;
    }

    if((void *)(long)arg->redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)arg->redirect_pkt->data_end)
        return 1;
    struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)arg->redirect_pkt->data;
    struct net_metadata metadata = {IS_NET_METADATA, arg->ctx->send_next, pkt_data_len, 0, arg->ctx->recv_next, arg->ctx->rwnd_size};
    if(meta_hdr->metadata_end > 4000)
        return 1;
    if((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(metadata) > (void *)(long)arg->redirect_pkt->data_end)
        return 1;
    __builtin_memcpy((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end), &metadata, sizeof(metadata));
    meta_hdr->metadata_end += sizeof(metadata);

    arg->ctx->send_next += pkt_data_len;

    return 0;
}

static __always_inline void send_ep(struct app_event *event, struct context *ctx,
    struct intermediate_output *inter_output, struct xdp_md *redirect_pkt) {

    // Q: can I assume that this variable always initialize as the same value as
    // ctx->send_next (both 0)?
    ctx->data_end += event->data_size;
 
    // Total data yet to transmit 
    __u32 data_rest = ctx->data_end - ctx->send_next;

    __u32 effective_window = ctx->cwnd_size;
    if(effective_window > ctx->last_rwnd_size)
        effective_window = ctx->last_rwnd_size;

    // Total data to transmit between send_next and cwnd_size
    __u32 bytes_to_send = 0;

    if(ctx->send_una + effective_window < ctx->send_next)
        return;
    else {
        __u32 window_avail = ctx->send_una + effective_window - ctx->send_next;
        if(data_rest < window_avail)
            bytes_to_send = data_rest;
        else
            bytes_to_send = window_avail;
    }

    // Note: ceil seems to not be working properly
    //__u32 num_loops = ceil(bytes_to_send / SMSS);
    __u32 num_loops = bytes_to_send / SMSS;
    if(bytes_to_send % SMSS != 0)
        num_loops += 1;
    //bpf_printk("NUM: %d", num_loops);
    struct send_loop_args arg;
    __builtin_memset(&arg, 0, sizeof(arg));
    arg.bytes_to_send = bytes_to_send;
    arg.ctx = ctx;
    arg.redirect_pkt = redirect_pkt;
    bpf_loop(num_loops, send_n_packets, &arg, 0);

    struct timer_event new_event;
    new_event.ev_flow_id = event->ev_flow_id;
    new_event.event_type = MISS_ACK;
    new_event.seq_num = ctx->send_una;
    initialize_timer(new_event, ctx->RTO, ACK_TIMEOUT);
}

static __always_inline void rto_ep(struct net_event *event, struct context *ctx,
    struct intermediate_output *inter_output, struct xdp_md *redirect_pkt) {

    inter_output->skip_ack_eps = 0;
    if(event->ack_seq < ctx->send_una || ctx->send_next < event->ack_seq) {
        inter_output->skip_ack_eps = 1;
        return;
    }

    if(ctx->first_rto) {
        ctx->SRTT = RTT;
        ctx->RTTVAR = RTT / 2;
        if(GRANULARITY_G >= 4 * ctx->RTTVAR)
            ctx->RTO = ctx->SRTT + GRANULARITY_G;
        else
            ctx->RTO = ctx->SRTT + 4 * ctx->RTTVAR;

        ctx->first_rto = 0;

    } else {
        ctx->RTTVAR = (1 - 1/4) * ctx->RTTVAR + 1/4 * llabs(ctx->SRTT - RTT);
        ctx->SRTT = (1 - 1/8) * ctx->SRTT + 1/8 * RTT;
        if(GRANULARITY_G >= 4 * ctx->RTTVAR)
            ctx->RTO = ctx->SRTT + GRANULARITY_G;
        else
            ctx->RTO = ctx->SRTT + 4 * ctx->RTTVAR;
    }
}

static __always_inline void fast_retr_rec_ep(struct net_event *event, struct context *ctx,
    struct intermediate_output *inter_output, struct xdp_md *redirect_pkt) {
    
    /*if(event->ack_seq < ctx->send_una || ctx->send_next < event->ack_seq)
        return;*/
    if(inter_output->skip_ack_eps)
        return;

    inter_output->change_cwnd = 1;

    if(event->ack_seq == ctx->last_ack) {
        ctx->duplicate_acks += 1;

        inter_output->change_cwnd = 0;

        if(ctx->duplicate_acks == 1) {
            ctx->flightsize_dupl = ctx->send_next - ctx->send_una;
        }

        if(ctx->duplicate_acks == 3) {

            __u32 opt1 = ctx->flightsize_dupl / 2;
            __u32 opt2 = 2 * SMSS;
            if(opt1 >= opt2)
                ctx->ssthresh = opt1;
            else
                ctx->ssthresh = opt2;

            ctx->cwnd_size = ctx->ssthresh + 3 * SMSS;
        }
        
        if(ctx->duplicate_acks != 3) {
            ctx->cwnd_size += SMSS;
        }

    } else {
        if(ctx->duplicate_acks > 0) {
            ctx->cwnd_size = ctx->ssthresh;
        }

        ctx->duplicate_acks = 0;
        ctx->last_ack = event->ack_seq;
    }
}

static __always_inline void slows_congc_ep(struct net_event *event, struct context *ctx,
    struct intermediate_output *inter_output, struct xdp_md *redirect_pkt) {

    if(inter_output->skip_ack_eps)
        return;

    if(inter_output->change_cwnd) {
        // Slow start
        if(ctx->cwnd_size < ctx->ssthresh) {
            ctx->cwnd_size += SMSS;
        }
        // Congestion control
        else {
            int add_cwnd = SMSS * SMSS / ctx->cwnd_size;
            if(add_cwnd == 0)
                add_cwnd = 1;
            // TODO: check if should use floor, ceil or nothing
            ctx->cwnd_size += add_cwnd;
        }
    }
}

static __always_inline void ack_net_ep(struct net_event *event, struct context *ctx,
    struct intermediate_output *inter_output, struct xdp_md *redirect_pkt) {

    /*if(event->ack_seq < ctx->send_una || ctx->send_next < event->ack_seq)
        return;*/   
    if(inter_output->skip_ack_eps)
        return;
    
    /*bpf_printk("SEND_NXT: %d, SEND_UNA: %d", ctx->send_next, ctx->send_una);
    __u16 flow = ((__u16)event->ev_flow_id.src_port) | (__u16)event->ev_flow_id.dest_port;
    bpf_printk("FLOW: %d", flow);*/

    ctx->last_rwnd_size = event->rwnd_size;

    // Get the space acknowledged
    ctx->send_una = event->ack_seq;

    // Total data yet to transmit 
    __u32 data_rest = ctx->data_end - ctx->send_next;
    if(data_rest == 0 && event->ack_seq == ctx->send_next) {
        bpf_printk("All packets sent and received");
        cancel_timer(event->ev_flow_id, ACK_TIMEOUT);
        return;
    }

    __u32 effective_window = ctx->cwnd_size;
    if(effective_window > ctx->last_rwnd_size)
        effective_window = ctx->last_rwnd_size;
    __u32 bytes_to_send = 0;

    // Fast retransmits the first unack packet
    if(ctx->duplicate_acks == 3) {
        bytes_to_send = SMSS;
        if(bytes_to_send > effective_window)
            bytes_to_send = effective_window;
        if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end)
            return;
        struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
        struct net_metadata metadata = {IS_NET_METADATA, ctx->send_una, bytes_to_send, 0, ctx->recv_next, ctx->rwnd_size};
        if(meta_hdr->metadata_end > 4000)
            return;
        if((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(metadata) > (void *)(long)redirect_pkt->data_end)
            return;
        __builtin_memcpy((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end), &metadata, sizeof(metadata));
        meta_hdr->metadata_end += sizeof(metadata);

        cancel_timer(event->ev_flow_id, ACK_TIMEOUT);
        struct timer_event new_event;
        new_event.ev_flow_id = event->ev_flow_id;
        new_event.event_type = MISS_ACK;
        new_event.seq_num = ctx->send_una;
        initialize_timer(new_event, ctx->RTO, ACK_TIMEOUT);

        return;
    }

    // Total data to transmit between send_next and cwnd_size
   //bpf_printk("duplicate %d %d", ctx->duplicate_acks, effective_window);

    if(ctx->send_una + effective_window < ctx->send_next)
        return;
    else {
        __u32 window_avail = ctx->send_una + effective_window - ctx->send_next;
        if(data_rest < window_avail)
            bytes_to_send = data_rest;
        else
            bytes_to_send = window_avail;
    }
    
    // Note: ceil seems to not be working properly
    //int num_to_send = ceil(ctx->cwnd_size / SMSS);
    __u32 num_loops = bytes_to_send / SMSS;
    if(bytes_to_send % SMSS != 0)
        num_loops += 1;
    //bpf_printk("NUM: %d", num_loops);

    struct send_loop_args arg;
    __builtin_memset(&arg, 0, sizeof(arg));
    arg.bytes_to_send = bytes_to_send;
    arg.ctx = ctx;
    arg.redirect_pkt = redirect_pkt;
    bpf_loop(num_loops, send_n_packets, &arg, 0);

    cancel_timer(event->ev_flow_id, ACK_TIMEOUT);
    struct timer_event new_event;
    new_event.ev_flow_id = event->ev_flow_id;
    new_event.event_type = MISS_ACK;
    new_event.seq_num = ctx->send_una;
    initialize_timer(new_event, ctx->RTO, ACK_TIMEOUT);
}

static long remove_recv_buffer(__u32 index, struct remove_data_array_args *arg) {
    //if(arg->curr_index >= MAX_NUM_CTX_PKT_INFO)
    //    return 1;
    //bpf_printk("LOOP SEQ %d", arg->ctx->data_recv_info_array[arg->curr_index].seq_num);

    if(arg->curr_index >= MAX_NUM_CTX_PKT_INFO)
        return 1;
    
    if(arg->ctx->data_recv_info_array[arg->curr_index].seq_num <= arg->recv_next) {

        int elem_recv_next = arg->ctx->data_recv_info_array[arg->curr_index].seq_num +
        arg->ctx->data_recv_info_array[arg->curr_index].data_len;

        if(elem_recv_next > arg->recv_next)
            arg->recv_next = elem_recv_next;
        
        if(arg->ctx->data_recv_array_tail == 0)
            arg->ctx->data_recv_array_tail = MAX_NUM_CTX_PKT_INFO - 1;
        else
            arg->ctx->data_recv_array_tail -= 1;
    } else
        return 1;
    
    if(arg->ctx->data_recv_array_head == arg->ctx->data_recv_array_tail)
        return 1;

    if(arg->curr_index == 0)
        arg->curr_index = MAX_NUM_CTX_PKT_INFO - 1;
    else
        arg->curr_index -= 1;

    return 0;
}

static long insert_recv_buffer(__u32 index, struct insert_data_array_args *arg) {

    if(arg->curr_index >= MAX_NUM_CTX_PKT_INFO)
        return 1;

    if(arg->found) {
        struct sent_pkt_info temp = arg->ctx->data_recv_info_array[arg->curr_index];
        arg->ctx->data_recv_info_array[arg->curr_index] = arg->new_elem;
        arg->new_elem = temp;
    }

    if(arg->curr_index >= MAX_NUM_CTX_PKT_INFO)
        return 1;
    
    if(arg->ctx->data_recv_info_array[arg->curr_index].seq_num == arg->new_elem.seq_num &&
        arg->ctx->data_recv_info_array[arg->curr_index].data_len == arg->new_elem.data_len && arg->found == 0) {
        return 1;
    }

    if(arg->ctx->data_recv_info_array[arg->curr_index].seq_num <= arg->new_elem.seq_num && arg->found == 0) {
        struct sent_pkt_info temp = arg->ctx->data_recv_info_array[arg->curr_index];
        arg->ctx->data_recv_info_array[arg->curr_index] = arg->new_elem;
        arg->new_elem = temp;
        arg->found = 1;
        arg->ctx->data_recv_array_tail = (arg->ctx->data_recv_array_tail + 1) % MAX_NUM_CTX_PKT_INFO;
    }

    if(arg->curr_index == arg->ctx->data_recv_array_tail) {
        return 1;
    }

    //bpf_printk("TEMP SEQ_NUM: %d TEMP DATA_LEN: %d", arg->new_elem.seq_num, arg->new_elem.data_len);

    arg->curr_index = (arg->curr_index + 1) % MAX_NUM_CTX_PKT_INFO;

    return 0;
}

static __always_inline void data_net_ep(struct net_event *event, struct context *ctx,
    struct intermediate_output *inter_output, struct xdp_md *redirect_pkt) {

    if((ctx->rwnd_size == 0 && event->data_len > 0) || 
    (event->seq_num > ctx->recv_next + ctx->rwnd_size) ||
    (event->seq_num + event->data_len - 1 < ctx->recv_next))
        return;

    //bpf_printk("\nEVENT SEQ: %d\nRECV NEXT: %d\n", event->seq_num, ctx->recv_next);
    //bpf_printk("\nDATA LEN: %d\n", event->data_len);
    // If interval between sequence number and (seq num + data len) contains recv_next
    if(event->seq_num <= ctx->recv_next && event->seq_num + event->data_len - 1 >= ctx->recv_next) {
        if(event->seq_num + event->data_len < ctx->recv_next + ctx->rwnd_size)
            ctx->recv_next = event->seq_num + event->data_len;
        else
            ctx->recv_next += ctx->rwnd_size;
        
        if(ctx->data_recv_array_head != ctx->data_recv_array_tail) {
            struct remove_data_array_args arg;
            __builtin_memset(&arg, 0, sizeof(arg));
            arg.ctx = ctx;
            arg.recv_next = ctx->recv_next;
            if(ctx->data_recv_array_tail == 0)
                arg.curr_index = MAX_NUM_CTX_PKT_INFO - 1;
            else
                arg.curr_index = ctx->data_recv_array_tail - 1;
            bpf_loop(MAX_NUM_CTX_PKT_INFO, remove_recv_buffer, &arg, 0);

            ctx->recv_next = arg.recv_next;
           //bpf_printk("TAIL: %d", ctx->data_recv_array_tail);
        }

    } else {
        if((ctx->data_recv_array_tail == MAX_NUM_CTX_PKT_INFO - 1 && ctx->data_recv_array_head == 0)||
        (ctx->data_recv_array_head == ctx->data_recv_array_tail + 1)) {
            bpf_printk("data_net_ep: no space available in data_recv_info_array");
        }
        struct insert_data_array_args arg;
        __builtin_memset(&arg, 0, sizeof(arg));
        arg.ctx = ctx;
        arg.new_elem.seq_num = event->seq_num;
        arg.new_elem.data_len = event->data_len;
        arg.curr_index = ctx->data_recv_array_head;
        arg.found = 0;
        bpf_loop(MAX_NUM_CTX_PKT_INFO, insert_recv_buffer, &arg, 0);
    }
}

static __always_inline void send_ack(struct net_event *event, struct context *ctx,
    struct intermediate_output *inter_output, struct xdp_md *redirect_pkt) {

    // Total data yet to transmit 
    __u32 data_rest = ctx->data_end - ctx->send_next;

    __u32 effective_window = ctx->cwnd_size;
    if(effective_window > ctx->last_rwnd_size)
        effective_window = ctx->last_rwnd_size;

    // Total data to transmit between send_next and cwnd_size
    __u32 bytes_to_send = 0;

    if(ctx->send_una + effective_window < ctx->send_next)
        return;
    else {
        __u32 window_avail = ctx->send_una + effective_window - ctx->send_next;
        if(data_rest < window_avail)
            bytes_to_send = data_rest;
        else
            bytes_to_send = window_avail;
        
        if (bytes_to_send > SMSS)
            bytes_to_send = SMSS;
    }
   //bpf_printk("\nBYTES: %d\n", bytes_to_send);
    
    if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end)
        return;
    struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
    struct net_metadata metadata = {IS_NET_METADATA, ctx->send_una, bytes_to_send, 1, ctx->recv_next, ctx->rwnd_size};
    if(meta_hdr->metadata_end > 4000)
        return;
    if((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(metadata) > (void *)(long)redirect_pkt->data_end)
        return;
    __builtin_memcpy((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end), &metadata, sizeof(metadata));
    meta_hdr->metadata_end += sizeof(metadata);
}

static __always_inline void app_feedback_ep(struct net_event *event, struct context *ctx,
    struct intermediate_output *inter_output, struct xdp_md *redirect_pkt) {

    if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end)
    return;
    struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
    struct app_metadata metadata = {IS_APP_METADATA, event->seq_num, event->data_len};
    if(meta_hdr->metadata_end > 4000)
        return;
    if((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(metadata) > (void *)(long)redirect_pkt->data_end)
        return;
    __builtin_memcpy((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end), &metadata, sizeof(metadata));
    meta_hdr->metadata_end += sizeof(metadata);
}

static __always_inline void ack_timeout_ep(struct timer_event *event, struct context *ctx,
    struct intermediate_output *inter_output, struct xdp_md *redirect_pkt) {

    //if(ctx->send_una >= event->seq_num) {
        // Slow start after a timeout
        ctx->cwnd_size = SMSS * 3;

        __u32 opt1 = (ctx->send_next - ctx->send_una) / 2;
        __u32 opt2 = 2 * SMSS;
        if(opt1 >= opt2)
            ctx->ssthresh = opt1;
        else
            ctx->ssthresh = opt2;

        // Q: is this right? Since we are retransmitting something, I think it would make sense
        // to use send_una instead of send_next
        __u32 data_rest = ctx->data_end - ctx->send_una;

        __u32 effective_window = ctx->cwnd_size;
        if(effective_window > ctx->last_rwnd_size)
            effective_window = ctx->last_rwnd_size;

        // Total data to transmit between send_next and cwnd_size
        __u32 bytes_to_send = 0;

        if(ctx->send_una + effective_window < ctx->send_next) {
            if(data_rest < effective_window)
                bytes_to_send = data_rest;
            else
                bytes_to_send = effective_window;
        } else {
            __u32 window_avail = ctx->send_una + effective_window - ctx->send_next;
            if(data_rest < window_avail)
                bytes_to_send = data_rest;
            else
                bytes_to_send = window_avail;
        }
        if (bytes_to_send > SMSS)
            bytes_to_send = SMSS;

        if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end)
            return;
        struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
        struct net_metadata metadata = {IS_NET_METADATA, ctx->send_una, bytes_to_send, 0, ctx->recv_next, ctx->rwnd_size};
        if(meta_hdr->metadata_end > 4000)
            return;
        if((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(metadata) > (void *)(long)redirect_pkt->data_end)
            return;
        __builtin_memcpy((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end), &metadata, sizeof(metadata));
        meta_hdr->metadata_end += sizeof(metadata);

        restart_timer(event->ev_flow_id, ctx->RTO, ACK_TIMEOUT);
    //}
}

static __always_inline void app_dispatcher(struct app_event * event,
struct context *ctx, struct xdp_md *redirect_pkt) {
	struct intermediate_output inter_output;
	switch (event->event_type)
	{
	case SEND:
		send_ep(event, ctx, &inter_output, redirect_pkt);
		break;
	default:
		break;
	}
}

static __always_inline void net_dispatcher(struct net_event * event,
struct context *ctx, struct xdp_md *redirect_pkt) {
	struct intermediate_output inter_output;
	switch (event->event_type)
	{
	case ACK:
        rto_ep(event, ctx, &inter_output, redirect_pkt);
        fast_retr_rec_ep(event, ctx, &inter_output, redirect_pkt);
        slows_congc_ep(event, ctx, &inter_output, redirect_pkt);
        ack_net_ep(event, ctx, &inter_output, redirect_pkt);
        break;
    case DATA:
        data_net_ep(event, ctx, &inter_output, redirect_pkt);
        send_ack(event, ctx, &inter_output, redirect_pkt);
        app_feedback_ep(event, ctx, &inter_output, redirect_pkt);
        break;
	default:
		break;
	}
}

static __always_inline void timer_dispatcher(struct timer_event * event,
struct context *ctx, struct xdp_md *redirect_pkt) {
	struct intermediate_output inter_output;
	switch (event->event_type)
	{
	case MISS_ACK:
        ack_timeout_ep(event, ctx, &inter_output, redirect_pkt);
        break;
	default:
		break;
	}
}

static __always_inline void prog_dispatcher(struct prog_event * event,
struct context *ctx, struct xdp_md *redirect_pkt) {
	//struct intermediate_output inter_output;
	switch (event->event_type)
	{
    case PROG_TEST:
        // So we won't get an error
        if(0)
            generic_event_enqueue(event, PROG_EVENT);
        break;
	default:
		break;
	}
}

static long ev_process_loop(__u32 index, struct sched_loop_args * arg) {
    int returned_type = next_event(arg->f_info);
    if(returned_type == -1) {
        return 1;
	}

	switch (returned_type)
    {
    case APP_EVENT:
    {
        //bpf_printk("APP_EVENT IS THE LARGEST");
    	struct app_event *ev = app_event_dequeue(arg->f_id,
            &(arg->f_info->app_info.len_app_queue), &(arg->f_info->app_info.app_head));
        if(!ev)
            return 1;
        app_dispatcher(ev, arg->ctx, arg->redirect_pkt);
		__sync_fetch_and_xor(&ev->occupied, 1);
        break;
    }
    
    case TIMER_EVENT:
    {
        //bpf_printk("TIMER_EVENT IS THE LARGEST");
        struct timer_event *ev = timer_event_dequeue(arg->f_id,
            &(arg->f_info->timer_info.len_timer_queue), &(arg->f_info->timer_info.timer_head));
        if(!ev)
            return 1;
        timer_dispatcher(ev, arg->ctx, arg->redirect_pkt);
        break;
    }
    
    case PROG_EVENT:
    {
        //bpf_printk("PROG_EVENT IS THE LARGEST");
        struct prog_event *ev = prog_event_dequeue(arg->f_id,
            &(arg->f_info->prog_info.len_prog_queue), &(arg->f_info->prog_info.prog_head));
        if(!ev)
            return 1;
        prog_dispatcher(ev, arg->ctx, arg->redirect_pkt);
        break;
    }
    
    default:
        return 1;
    }

    return 0;
}

static __always_inline int net_ev_process(struct xdp_md *redirect_pkt, __u32 * f_id,
    struct context **flow_context) {

    struct net_event net_ev[MAX_NET_EVENTS];

    __u8 ret = mutate_pkt(redirect_pkt, net_ev);
    if(!ret)
        return 0;

    *f_id = net_ev[0].ev_flow_id;
    *flow_context = retrieve_ctx(*f_id);
    if(!(*flow_context)) {
        bpf_printk("net_ev_process: Couldn't retrive ctx");
        return 0;
    }

    // Saving cwnd_size to metadata_hdr (measure at userspace)
    if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end)
        return 0;
    struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
    meta_hdr->cwnd_size = (*flow_context)->cwnd_size;

    if(ret == 1) // One network packet
        net_dispatcher(&net_ev[0], *flow_context, redirect_pkt);
    if(ret == 2) { // Two network packets
        net_dispatcher(&net_ev[0], *flow_context, redirect_pkt);
        net_dispatcher(&net_ev[0], *flow_context, redirect_pkt);
    }

    return 1;
}

SEC("xdp")
int net_arrive(struct xdp_md *redirect_pkt)
{
    //__u64 arrival_time = bpf_ktime_get_ns();

    struct sched_loop_args arg;
    arg.ctx = NULL;
    arg.redirect_pkt = redirect_pkt;

    // Process network event first
    if(!net_ev_process(redirect_pkt, &arg.f_id, &arg.ctx))
        return XDP_DROP;

    //bpf_printk("CPU: %d", bpf_get_smp_processor_id());
        
    arg.f_info = find_queue_flow_info(arg.f_id);
    if(!arg.f_info)
        return XDP_DROP;

    update_app_len(&arg.f_info->app_info, arg.f_id);

    bpf_loop(MAX_NUM_PROCESSED_EVENTS, ev_process_loop, &arg, 0);

    /* An entry here means that the corresponding queue_id
     * has an active AF_XDP socket bound to it. */
    int rx_queue_index = redirect_pkt->rx_queue_index;
    if (bpf_map_lookup_elem(&xsks_map, &rx_queue_index)) {
        /*__u64 finish_time = bpf_ktime_get_ns();
        int cpu = bpf_get_smp_processor_id();
        struct info *value = bpf_map_lookup_elem(&info_array, &cpu);
        if(!value)
            return XDP_DROP;
        value->counter += 1;
        value->latency += (finish_time - arrival_time);*/
        ////bpf_printk("TEST %d %d", cpu, rx_queue_index);
        return bpf_redirect_map(&xsks_map, rx_queue_index, 0);
    }

    return XDP_DROP;
}

char _license[] SEC("license") = "GPL";

