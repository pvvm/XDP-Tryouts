/* SPDX-License-Identifier: GPL-2.0 */

#include <linux/bpf.h>

#include <linux/in.h>

#include <linux/if_ether.h>

#include <time.h>

#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
#include "../common/parsing_helpers.h"
#include "../common/rewrite_helpers.h"

#include "common_def.h"

#define ONE_SEC 1000000000
#define TEN_SEC 10000000000


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
    __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
    __type(key, struct flow_id);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
    __array(values, struct inner_app_array);
} outer_app_hash SEC(".maps") = {
    .values = {(void*)&inner_app_array},
};

struct {
    __uint(type, BPF_MAP_TYPE_HASH);
    __type(key, struct flow_id);
    __type(value, __u32);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
} tail_app_hash SEC(".maps");

/*--------------- TIMER EVENT MAPS ---------------*/

struct inner_timer_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct timer_event);
    __uint(max_entries, MAX_EVENT_QUEUE_LEN);
} inner_timer_array SEC(".maps");

struct outer_timer_hash {
    __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
    __type(key, struct flow_id);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
    __array(values, struct inner_timer_array);
} outer_timer_hash SEC(".maps") = {
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
    __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
    __type(key, struct flow_id);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
    __array(values, struct inner_prog_array);
} outer_prog_hash SEC(".maps") = {
    .values = {(void*)&inner_prog_array},
};

/*--------------- FLOW INFO MAPS ---------------*/

struct {
    __uint(type, BPF_MAP_TYPE_HASH);
    __type(key, struct flow_id);
    __type(value, struct queue_flow_info);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
} queue_flow_info_hash SEC(".maps");

/*--------------- TIMER TRIGGER MAP ---------------*/

/*struct timer_trigger_inner_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct timer_trigger);
    __uint(max_entries, MAX_NUMBER_TIMERS);
} timer_trigger_inner_array SEC(".maps");

struct timer_trigger_outer_hash {
    __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
    __type(key, struct flow_id);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
    __array(values, struct timer_trigger_inner_array);
} timer_trigger_outer_hash SEC(".maps") = {
    .values = {(void*)&timer_trigger_inner_array},
};*/

struct {
    __uint(type, BPF_MAP_TYPE_HASH);
    __type(key, struct timer_trigger_id);
    __type(value, struct timer_trigger);
    __uint(max_entries, (MAX_NUMBER_FLOWS + 1) * MAX_NUMBER_TIMERS);
} timer_trigger_hash SEC(".maps");


/*--------------- CONTEXT HASH MAP ---------------*/

struct {
    __uint(type, BPF_MAP_TYPE_HASH);
    __type(key, struct flow_id);
    __type(value, struct context);
    __uint(max_entries, MAX_NUMBER_FLOWS + 1);
} context_hash SEC(".maps");


static __always_inline int initialize_timer(struct timer_event, __u64, enum timer_id);


// Note: make this function more complex in the future
static __always_inline void define_minor_type(struct net_event *net_ev) {
    net_ev->event_type = ACK;
}

// TODO: implement the hash map
static __always_inline __u8 parse_packet(void *data, void *data_end,
    struct net_event *net_ev, struct metadata_hdr *meta_hdr) {
    
    struct ethhdr *eth;
    struct iphdr *iphdr;
    struct tcphdr *tcph;

    struct hdr_cursor nh;
    int eth_type, ip_type;

    nh.pos = data;

    eth_type = parse_ethhdr(&nh, data_end, &eth);
    if (eth_type != bpf_htons(ETH_P_IP)) {
        bpf_printk("parse_packet: error while parsing ETH header");
        return 0;
    }

    ip_type = parse_iphdr(&nh, data_end, &iphdr);
    if(ip_type != IPPROTO_TCP) {
        bpf_printk("parse_packet: error while parsing IP header");
        return 0;
    }

    __be32 saddr = iphdr->saddr; 
    __u8 src_ip;
    src_ip = saddr & 0xFF;
    src_ip = ((saddr >> 8) & 0xFF) ^ src_ip;
    src_ip = ((saddr >> 16) & 0xFF) ^ src_ip;
    src_ip = ((saddr >> 24) & 0xFF) ^ src_ip;
    net_ev->ev_flow_id.src_ip = src_ip;

    __be32 daddr = iphdr->daddr;
    __u8 dst_ip;
    dst_ip = daddr & 0xFF;
    dst_ip = ((daddr >> 8) & 0xFF) ^ dst_ip;
    dst_ip = ((daddr >> 16) & 0xFF) ^ dst_ip;
    dst_ip = ((daddr >> 24) & 0xFF) ^ dst_ip;
    net_ev->ev_flow_id.dest_ip = dst_ip;

    if(parse_tcphdr(&nh, data_end, &tcph) ==  -1) {
        bpf_printk("parse_packet: error while parsing TCP header");
        return 0;
    }

    __be16 sport = bpf_ntohs(tcph->source);
    __u8 src_port;
    src_port = sport & 0xFF;
    src_port = ((sport >> 8) & 0xFF) ^ src_port;
    net_ev->ev_flow_id.src_port = src_port;

    __be16 dport = bpf_ntohs(tcph->dest);
    __u8 dst_port;
    dst_port = dport & 0xFF;
    dst_port = ((dport >> 8) & 0xFF) ^ dst_port;
    net_ev->ev_flow_id.dest_port = dst_port;

    //bpf_printk("%d %d", net_ev->ev_flow_id.src_ip, net_ev->ev_flow_id.dest_ip);
    //bpf_printk("%d %d", net_ev->ev_flow_id.src_port, net_ev->ev_flow_id.dest_port);

    define_minor_type(net_ev);

    __builtin_memcpy(meta_hdr->src_mac, eth->h_source, ETH_ALEN);
    __builtin_memcpy(meta_hdr->dst_mac, eth->h_dest, ETH_ALEN);
    meta_hdr->src_ip = iphdr->saddr;
    meta_hdr->dst_ip = iphdr->daddr;
    meta_hdr->src_port = tcph->source;
    meta_hdr->dst_port = tcph->dest;

    // Note: identifies if it is a bpf_prog_run packet via IP header ID
    if(iphdr->id == 65535)
        return 2;

    return 1;
}

static __always_inline __u8 mutate_pkt(struct xdp_md *redirect_pkt, struct net_event *net_ev) {

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

    bpf_xdp_adjust_tail(redirect_pkt, 2000);

    return ret;
}

static __always_inline struct context * retrieve_ctx(struct flow_id flow) {
    struct context *ctx = bpf_map_lookup_elem(&context_hash, &flow);
    if(!ctx) {
        struct context new_ctx = {0, 0, 0};
        bpf_map_update_elem(&context_hash, &flow, &new_ctx, BPF_NOEXIST);
        ctx = bpf_map_lookup_elem(&context_hash, &flow);
        if(!ctx) {
            return NULL;
        }
        return ctx;
    }
    return ctx;
}

static __always_inline void update_app_len(struct app_info *app_info, struct flow_id f_id) {

    __u32 *app_tail = bpf_map_lookup_elem(&tail_app_hash, &f_id);
    //__u32 *app_tail = bpf_map_lookup_elem(&tail_app_hash, &ev_flow_id);
    if(!app_tail) {
        __u32 new_tail = 0;
        // Note: change this later when we can dynamicaly assign entries to MoM arrays
        //bpf_map_update_elem(&tail_app_hash, &ev_flow_id, &new_tail, BPF_NOEXIST);
        //app_tail = bpf_map_lookup_elem(&tail_app_hash, &ev_flow_id);
        bpf_map_update_elem(&tail_app_hash, &f_id, &new_tail, BPF_NOEXIST);
        app_tail = bpf_map_lookup_elem(&tail_app_hash, &f_id);
        if(!app_tail) {
            bpf_printk("update_app_len: couldn't get entry from app tail map");
            return;
        }
    }
    app_info->app_tail = *app_tail;
    app_info->len_app_queue = (app_info->app_tail - app_info->app_head + MAX_EVENT_QUEUE_LEN) % MAX_EVENT_QUEUE_LEN;
}


static __always_inline struct queue_flow_info * find_queue_flow_info(struct flow_id f_id) {

    struct queue_flow_info *f_info = bpf_map_lookup_elem(&queue_flow_info_hash, &f_id);
    if(!f_info) {
        struct queue_flow_info new_f_info = {{0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0}};
        bpf_map_update_elem(&queue_flow_info_hash, &f_id, &new_f_info, BPF_NOEXIST);
        f_info = bpf_map_lookup_elem(&queue_flow_info_hash, &f_id);
        if(!f_info) {
            bpf_printk("find_queue_flow_info: Couldn't get entry from flow info inner map");
            return NULL;
        }
        return f_info;
    }
    return f_info;
}

static __always_inline int try_to_enqueue(void * map, void * event,
    struct flow_id f_id, int * queue_len, int *tail) {

    if(*queue_len == MAX_EVENT_QUEUE_LEN - 1) {
        bpf_printk("Queue is full: unable to enqueue event");
        return 0;
    }

    void *inner_array = bpf_map_lookup_elem(map, &f_id);
    if(!inner_array) {
        bpf_printk("try_to_enqueue: Couldn't get entry from outer map");
        return 0;
    }

    if(bpf_map_update_elem(inner_array, tail, event, BPF_ANY)) {
        bpf_printk("try_to_enqueue: Couldn't update entry from inner map");
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
        bpf_printk("PROG_EVENT");
        struct prog_event enq_event = *(struct prog_event *) event;
        struct queue_flow_info *f_info = find_queue_flow_info(enq_event.ev_flow_id);
        if(!f_info)
            return;
        if(!try_to_enqueue(&outer_prog_hash, event, enq_event.ev_flow_id, &(f_info->prog_info.len_prog_queue),
            &(f_info->prog_info.prog_tail))) {
            bpf_printk("Unable to enqueue PROG_EVENT");
        }
        break;
    }
    
    default:
        return;
    }
}

/*static __u64 loop_hash_info(struct bpf_map *map, struct flow_id *key, struct queue_flow_info *val, struct flow_loop_data *data) {
    __u32 current_max = data->len_app_queue + data->len_net_queue + data->len_timer_queue + data->len_prog_queue;

    __u32 current_sum = val->app_info.len_app_queue + val->net_info.len_net_queue +
        val->timer_info.len_timer_queue + val->prog_info.len_prog_queue;

    if(current_sum > current_max) {
        data->len_app_queue = val->app_info.len_app_queue;
        data->len_net_queue = val->net_info.len_net_queue;
        data->len_timer_queue = val->timer_info.len_timer_queue;
        data->len_prog_queue = val->prog_info.len_prog_queue;
        data->f_id = *key;
    }

    return 0;
}

static __always_inline int next_flow(struct flow_id *flow, int cpu_id) {
    struct inner_flow_info_hash *flow_info_hash = bpf_map_lookup_elem(&outer_flow_info_array, &cpu_id);
    if(!flow_info_hash) {
        bpf_printk("next_flow: Couldn't get entry from flow info outer map");
        return 0;
    }
    
    struct flow_loop_data data = {{0, 0, 0, 0}, 0, 0, 0, 0};

    bpf_for_each_map_elem(flow_info_hash, loop_hash_info, &data, 0);

    if(data.f_id.src_ip == 0 && data.f_id.dest_ip == 0 &&
        data.f_id.src_port == 0 && data.f_id.dest_port == 0)
        return 0;

    *flow = data.f_id;

    return 1;
}*/

static __always_inline int next_event(struct queue_flow_info * f_info) {
    // App, net, timer, prog. App has the lowest priority, timer has the highest
    __u32 type_priorities[3] = {1, 3, 2};
    type_priorities[0] *= f_info->app_info.len_app_queue;
    type_priorities[1] *= f_info->timer_info.len_timer_queue;
    type_priorities[2] *= f_info->prog_info.len_prog_queue;

    bpf_printk("APP: %d", type_priorities[0]);
    bpf_printk("TIMER: %d PROG: %d", type_priorities[1], type_priorities[2]);

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

static __always_inline void * timer_event_dequeue(struct flow_id f_id,
    __u64 * queue_len, int * head) {
    if(__sync_fetch_and_or(queue_len, 0) == 0) {
        bpf_printk("timer_event_dequeue: queue is empty, unable to dequeue an event");
        return NULL;
    }
    
    void * inner_flow_array = bpf_map_lookup_elem(&outer_timer_hash, &f_id);
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

static __always_inline void * generic_event_dequeue(void * outer_event_hash, struct flow_id f_id,
    int * queue_len, int * head) {
    if(*queue_len == 0) {
        bpf_printk("prog_event_dequeue: queue is empty, unable to dequeue an event");
        return NULL;
    }
    
    void * inner_flow_array = bpf_map_lookup_elem(outer_event_hash, &f_id);
    //void * inner_flow_array = bpf_map_lookup_elem(outer_event_hash, &f_id);
    if(!inner_flow_array) {
        bpf_printk("event_dequeue: couldn't get entry from flow info outer map");
        return NULL;
    }

    void * event = bpf_map_lookup_elem(inner_flow_array, head);
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

static __always_inline int timer_event_enqueue(void *map, struct flow_id *f_id, struct timer_trigger *val) {
    struct timer_event event = val->t_event;
    event.valid_bit = 1;

    bpf_printk("TIMER_EVENT");
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

    struct inner_timer_array *inner_array = bpf_map_lookup_elem(&outer_timer_hash, &event.ev_flow_id);
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

/*static int create_timer_event(void *map, struct flow_id *flow, struct timer_trigger *val) {
    val->triggered = 0;
    struct timer_event new_event = val->t_event;
    new_event.valid_bit = 1;
    __u32 cpu_id = val->cpu_id;
    timer_event_enqueue(&new_event, cpu_id);

    return 0;
}*/

/*static __u64 find_timer_index_loop(struct bpf_map *map, __u32 * index,
    struct timer_trigger *map_entry, struct timer_loop_args * arg) {

    arg->index = *index;
    //bpf_printk("TEST %d", arg->index);

    if(!map_entry->triggered)
        return 1;

    // Placeholder value
    if(arg->index == MAX_NUMBER_TIMERS - 1)
        arg->index = NO_TIMER_AVAILABLE;

    return 0;
}*/

static __always_inline int cancel_timer(struct flow_id f_id,
    enum timer_id index) {

    struct timer_trigger_id timer_id = {f_id, index};
    struct timer_trigger *map_entry = bpf_map_lookup_elem(&timer_trigger_hash, &timer_id);
    if(!map_entry) {
        bpf_printk("restart_timer: Couldn't find inner map entry");
        return -1;
    }

    if(!map_entry->triggered) {
        bpf_printk("cancel_timer: timer isn't currently triggered");
        return -1;
    }

    if(!bpf_timer_cancel(&(map_entry->timer))) {
        bpf_printk("cancel_timer: couldn't cancel timer");
        return -1;
    }

    return 0;
}

static __always_inline int restart_timer(struct flow_id f_id, __u64 time,
    enum timer_id index) {

    struct timer_trigger_id timer_id = {f_id, index};
    struct timer_trigger *map_entry = bpf_map_lookup_elem(&timer_trigger_hash, &timer_id);
    if(!map_entry) {
        bpf_printk("restart_timer: Couldn't find inner map entry");
        return -1;
    }

    /*if(!map_entry->triggered) {
        bpf_printk("restart_timer: timer isn't currently triggered");
        return -1;
    }*/

    if(bpf_timer_start(&(map_entry->timer), time, 0) != 0) {
        bpf_printk("restart_timer: couldn't restart timer");
        return -1;
    }

    return 0;
}

static __always_inline struct timer_trigger *retrieve_timer(struct flow_id f_id, enum timer_id index) {
    struct timer_trigger_id timer_id = {f_id, index};
    struct timer_trigger *map_entry = bpf_map_lookup_elem(&timer_trigger_hash, &timer_id);
    if(!map_entry) {
        struct timer_trigger new_entry;
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
    if(!map_entry)
        return -1;

    /*if(map_entry->triggered) {
        bpf_printk("initialize_timer: timer already triggered");
        return -1;
    }*/

    map_entry->t_event = event;
    map_entry->triggered = 1;

    long int err = bpf_timer_init(&(map_entry->timer), &timer_trigger_hash, CLOCK_BOOTTIME);
    /*if(i != 0) {
        bpf_printk("Error while initializing timer: %ld", i);
    }*/

    // Sets the function to be called after the timer triggers
    err = bpf_timer_set_callback(&(map_entry->timer), timer_event_enqueue);
    if(err != 0) {
        bpf_printk("Error while setting callback: %ld", err);
    }

    bpf_timer_start(&(map_entry->timer), time, 0);

    return 0;
}

static __always_inline void example_ep_app(struct net_event *event, struct context *ctx,
    struct intermediate_output *inter_output, struct xdp_md *redirect_pkt) {

    if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end)
        return;
    struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
    struct app_metadata metadata = {IS_APP_METADATA, 6, 7, 8, 9};
    if(meta_hdr->metadata_end > 4000)
        return;
    if((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(metadata) > (void *)(long)redirect_pkt->data_end)
        return;
    __builtin_memcpy((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end), &metadata, sizeof(metadata));
    meta_hdr->metadata_end += sizeof(metadata);
}

static __always_inline void example_ep_net(struct net_event *event, struct context *ctx,
    struct intermediate_output *inter_output, struct xdp_md *redirect_pkt) {
     
    struct timer_event new_event;
    new_event.ev_flow_id = event->ev_flow_id;
    new_event.event_type = MISS_ACK;
    new_event.value = 0;
    initialize_timer(new_event, TEN_SEC, EP_TIMER_TEST);
    if(0) { 
        restart_timer(new_event.ev_flow_id, ONE_SEC, EP_TIMER_TEST);
        cancel_timer(new_event.ev_flow_id, EP_TIMER_TEST);
    }

    struct prog_event new_prog_ev;
    for(int i = 0; i < 1; i++) {
        new_prog_ev.ev_flow_id = event->ev_flow_id;
        new_prog_ev.event_type = PROG_TEST;
        new_prog_ev.value = 0;
        generic_event_enqueue(&new_prog_ev, PROG_EVENT);
    }

    if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end)
        return;
    struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
    struct net_metadata metadata = {IS_NET_METADATA, 1, 2};
    if(meta_hdr->metadata_end > 4000)
        return;
    if((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(metadata) > (void *)(long)redirect_pkt->data_end)
        return;
    __builtin_memcpy((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end), &metadata, sizeof(metadata));
    meta_hdr->metadata_end += sizeof(metadata);
}

static __always_inline void dispatcher(void * event, enum minor_event_type type,
    struct context *ctx, struct xdp_md *redirect_pkt) {

    struct intermediate_output inter_output;

    switch (type)
    {
    case SEND:
        bpf_printk("SEND");
        example_ep_app(event, ctx, &inter_output, redirect_pkt);
        break;
    
    case ACK:
        bpf_printk("ACK");
        example_ep_net(event, ctx, &inter_output, redirect_pkt);
        break;
    
    case MISS_ACK:
        bpf_printk("MISS_ACK");
        break;
    
    case PROG_TEST:
        bpf_printk("PROG_TEST");
        break;
    
    default:
        return;
    }
}

static __always_inline void * scheduler(struct sched_loop_args * arg, __u8 * is_app_event,
    __u32 *minor_type) {
    struct queue_flow_info *f_info = arg->f_info;
    struct flow_id f_id = arg->f_id;

    int returned_type = next_event(f_info);
    if(returned_type == -1)
        return NULL;

    void * ev;

    switch (returned_type)
    {
    case APP_EVENT:
    {
        bpf_printk("APP_EVENT IS THE LARGEST");
        ev = generic_event_dequeue(&outer_app_hash, f_id,
            &(f_info->app_info.len_app_queue), &(f_info->app_info.app_head));
        if(!ev)
            return NULL;
        struct app_event * cast_ev = (struct app_event *) ev;
        *minor_type = cast_ev->event_type;
        *is_app_event = 1;
        break;
    }
    
    case TIMER_EVENT:
    {
        bpf_printk("TIMER_EVENT IS THE LARGEST");
        ev = timer_event_dequeue(f_id,
            &(f_info->timer_info.len_timer_queue), &(f_info->timer_info.timer_head));
        if(!ev)
            return NULL;
        struct timer_event * cast_ev = (struct timer_event *) ev;
        *minor_type = cast_ev->event_type;
        break;
    }
    
    case PROG_EVENT:
    {
        bpf_printk("PROG_EVENT IS THE LARGEST");
        ev = generic_event_dequeue(&outer_prog_hash, f_id,
            &(f_info->prog_info.len_prog_queue), &(f_info->prog_info.prog_head));
        if(!ev)
            return NULL;
        struct prog_event * cast_ev = (struct prog_event *) ev;
        *minor_type = cast_ev->event_type;
        break;
    }
    
    default:
        return NULL;
    }
    return ev;
}

static long ev_process_loop(__u32 index, struct sched_loop_args * arg) {
    __u8 is_app_event = 0;
    __u32 minor_type;
    void * ev = scheduler(arg, &is_app_event, &minor_type);
    if(!ev)
        return 1;

    if(is_app_event) {
        struct app_event *app_ev = (struct app_event *)ev;
        struct app_event new_ev;
        new_ev.ev_flow_id = app_ev->ev_flow_id;
        new_ev.event_type = app_ev->event_type;
        new_ev.occupied = app_ev->occupied;
        new_ev.value = app_ev->value;
        // Set occupied bit to 0
        __sync_fetch_and_xor(&app_ev->occupied, 1);
        dispatcher(&new_ev, minor_type, arg->ctx, arg->redirect_pkt);
    } else {
        dispatcher(ev, minor_type, arg->ctx, arg->redirect_pkt);
    }

    return 0;
}

static __always_inline int net_ev_process(struct xdp_md *redirect_pkt, struct flow_id * f_id,
    struct context **flow_context) {

    struct net_event net_ev;

    __u8 ret = mutate_pkt(redirect_pkt, &net_ev);
    if(!ret)
        return 0;

    *f_id = net_ev.ev_flow_id;
    *flow_context = retrieve_ctx(*f_id);
    if(!(*flow_context)) {
        bpf_printk("net_ev_process: Couldn't retrive ctx");
        return 0;
    }

    if(ret == 1)
        dispatcher(&net_ev, net_ev.event_type, *flow_context, redirect_pkt);

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
        
    arg.f_info = find_queue_flow_info(arg.f_id);
    if(!arg.f_info)
        return XDP_DROP;

    update_app_len(&arg.f_info->app_info, arg.f_id);

    bpf_loop(MAX_NUM_PROCESSED_EVENTS, ev_process_loop, &arg, 0);

    if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end)
        return XDP_DROP;
    struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
    bpf_printk("%d %d", meta_hdr->data_len, meta_hdr->metadata_end);

    /* An entry here means that the correspnding queue_id
     * has an active AF_XDP socket bound to it. */
    int rx_queue_index = redirect_pkt->rx_queue_index;
    //bpf_printk("CPU: %d", bpf_get_smp_processor_id());
    if (bpf_map_lookup_elem(&xsks_map, &rx_queue_index)) {
        /*__u64 finish_time = bpf_ktime_get_ns();
        int cpu = bpf_get_smp_processor_id();
        struct info *value = bpf_map_lookup_elem(&info_array, &cpu);
        if(!value)
            return XDP_DROP;
        value->counter += 1;
        value->latency += (finish_time - arrival_time);*/
        //bpf_printk("TEST %d %d", cpu, rx_queue_index);
        return bpf_redirect_map(&xsks_map, rx_queue_index, 0);
    }

    return XDP_DROP;
}

char _license[] SEC("license") = "GPL";

