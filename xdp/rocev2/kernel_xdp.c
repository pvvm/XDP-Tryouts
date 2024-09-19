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

//int pkt_counter = 0;


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

static __always_inline int parse_aethdr(struct hdr_cursor *nh, void *data_end, struct AETHeader **aethdr)
{
	int is_ack;
	struct AETHeader *h = nh->pos;

	if (h + 1 > data_end)
		return -1;

	nh->pos  = h + 1;
	*aethdr = h;

	is_ack = h->ack;
	if (is_ack < 0)
		return -1;

	return is_ack;
}

static __always_inline int parse_rethdr(struct hdr_cursor *nh, void *data_end, struct RETHeader **bthdr)
{
	int key;
	struct RETHeader *h = nh->pos;

	if (h + 1 > data_end)
		return -1;

	nh->pos  = h + 1;
	*bthdr = h;

	key = h->rkey;
	if (key < 0)
		return -1;

	return key;
}

static __always_inline int parse_bthhdr(struct hdr_cursor *nh, void *data_end, struct BTHeader **bthdr)
{
	int opcode;
	struct BTHeader *h = nh->pos;

	if (h + 1 > data_end)
		return -1;

	nh->pos  = h + 1;
	*bthdr = h;

	opcode = h->opcode;
	if (opcode < 0)
		return -1;

	return opcode;
}

static __always_inline __u32 * retrieve_flow_array_id(struct flow_id flow_hash_id) {
    __u32 * flow_array_id = bpf_map_lookup_elem(&flow_id_hash, &flow_hash_id);
    if(!flow_array_id) {
        bpf_printk("retrieve_flow_array_id: flow_array_id wasn't correctly set");
        return NULL;
    }
    return flow_array_id;
}

static __always_inline __u8 define_minor_type(struct net_event net_ev[MAX_NET_EVENTS], __u16 opcode,
struct hdr_cursor nh, void *data_end, struct udphdr *udph, struct BTHeader *bthdr) {
	if(opcode == 6 || opcode == 7 || opcode == 8 || opcode == 10) {
		struct RETHeader *reth;
		if(parse_rethdr(&nh, data_end, &reth) == -1)
			return 0;
		net_ev[0].event_type = WRITE_DATA;
		net_ev[0].data_len = udph->len - (8 + sizeof(struct BTHeader));
		net_ev[0].transit_addr = reth->raddr;
		net_ev[0].opcode = bthdr->opcode;
		net_ev[0].psn = bthdr->psn;
		net_ev[0].ack_req = bthdr->ack_req;
		net_ev[0].pkt_bytes_size = udph->len;
		// TODO: change this later
		net_ev[0].qp_id = 0;
		net_ev[0].wr_id = 0;
		return 2;

	} else if(opcode == 17) {
		struct AETHeader *aeth;
		if(parse_aethdr(&nh, data_end, &aeth) == -1)
			return 0;
		net_ev[0].event_type = ACK;
		return 3;
	}
    return 1;
}

static __always_inline __u8 parse_packet(void *data, void *data_end,
    struct net_event net_ev[MAX_NET_EVENTS], struct metadata_hdr *meta_hdr) {
    struct ethhdr *eth;
    struct iphdr *iphdr;
    //struct tcphdr *tcph;
	struct udphdr *udph;

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

    if(parse_udphdr(&nh, data_end, &udph) ==  -1) {
        bpf_printk("parse_packet: error while parsing UDP header");
        return 0;
    }
    flow_hash_id.src_port = bpf_ntohs(udph->source);
    flow_hash_id.dest_port = bpf_ntohs(udph->dest);


	struct BTHeader *bthdr;
	int opcode = parse_bthhdr(&nh, data_end, &bthdr);
	if(opcode ==  -1) {
        bpf_printk("parse_packet: error while parsing BTH header");
        return 0;
    }

    __u32 * flow_array_id = retrieve_flow_array_id(flow_hash_id);
    if(!flow_array_id)
        return 0;
    net_ev[0].ev_flow_id = *flow_array_id;
    net_ev[0].data_len = bpf_ntohs(iphdr->tot_len) - sizeof(struct iphdr) - sizeof(struct tcphdr);

    __builtin_memcpy(meta_hdr->src_mac, eth->h_source, ETH_ALEN);
    __builtin_memcpy(meta_hdr->dst_mac, eth->h_dest, ETH_ALEN);
    meta_hdr->src_ip = iphdr->saddr;
    meta_hdr->dst_ip = iphdr->daddr;
    meta_hdr->src_port = udph->source;
    meta_hdr->dst_port = udph->dest;

	__u8 ret = define_minor_type(net_ev, opcode, nh, data_end, udph, bthdr);
	if(ret == 0)
		return 0;

	// Note: identifies if it is a bpf_prog_run packet via IP header ID
	if(iphdr->id == 65535) {
        return 10;
    }

    return ret;
}

static __always_inline __u8 mutate_pkt(struct xdp_md *redirect_pkt, struct net_event net_ev[MAX_NET_EVENTS]) {

    void *data_end = (void *)(long)redirect_pkt->data_end;
    void *data     = (void *)(long)redirect_pkt->data;

    __u32 pkt_len = data_end - data;

    __u32 original_header_len = sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct udphdr) + sizeof(struct BTHeader);

    __u32 new_header_len = sizeof(struct metadata_hdr);

    struct metadata_hdr new_hdr;
    new_hdr.data_len = pkt_len - original_header_len;

    __u8 ret = parse_packet(data, data_end, net_ev, &new_hdr);
    if(!ret) {
        return 0;
	}
	
	if(ret == 2) {
		original_header_len += sizeof(struct RETHeader);
	} else if(ret == 3) {
		original_header_len += sizeof(struct AETHeader);
	}

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
    if(err != 0) {
        bpf_printk("Error while initializing timer: %ld", err);
    }

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
/*static long loop_function0(__u32 index, struct loop_arg0 *arg)
{
	if(!(arg->index < arg->ev->length )) {
		return 1;
	}
	struct net_metadata pkt_ev;
	pkt_ev.type_metadata = IS_NET_METADATA;
	pkt_ev.read_from_mem = 1;
	pkt_ev.hdr_combination = 0;
	pkt_ev.address = arg->ev->addr + arg->index;
	__u32 data_len = arg->ctx->MTU;
	if( arg->index + arg->ctx->MTU < arg->ev->length )
	{
		pkt_ev.length = arg->ctx->MTU;
	}
	else
	{
		data_len = arg->ev->length - arg->index;
		pkt_ev.length = data_len;
	}
	
	struct BTHeader bth = {};
	if( arg->ev->length <= arg->ctx->MTU )
	{
		bth.opcode = 4;
		arg->first_psn = arg->ctx->nPSN;
	}
	else
	{
		if( arg->index == 0 )
		{
			bth.opcode = 0;
			arg->first_psn = arg->ctx->nPSN;
		}
		else
		{
			if( arg->index + arg->ctx->MTU >= arg->ev->length )
			{
				bth.opcode = 2;
			}
			else
			{
				bth.opcode = 1;
			}
			
		}
		
	}
	
	bth.ack_req = arg->ev->ack_req;
	bth.dest_qp = arg->ctx->dest_qp;
	bth.psn = arg->ctx->nPSN;
	arg->ctx->nPSN = arg->ctx->nPSN + 1;
	struct UDPHeader udp = {};
	udp.src_port = arg->ctx->src_port;
	udp.dst_port = arg->ctx->dst_port;
	udp.length = 8 + sizeof( bth ) + data_len;
	pkt_ev.udp = udp;
	pkt_ev.bth = bth;
	struct packet_info save_packet = {};
	save_packet.pkt_ev = pkt_ev;
	save_packet.psn = bth.psn;
	save_packet.ack_req = bth.ack_req;
	save_packet.wr_id = arg->ev->wr_id;
	save_packet.acked = 0;
	save_packet.SSN = arg->ctx->SSN;
	arg->ctx->SSN = arg->ctx->SSN + 1;
	if(arg->ctx->num_sent_packets >= 500){
		return 1;
	}arg->ctx->sent_packets[ arg->ctx->num_sent_packets ] = save_packet;
	arg->ctx->num_sent_packets = arg->ctx->num_sent_packets + 1;
	arg->index = arg->index + arg->ctx->MTU ;
	return 0;
}
static __always_inline void SendProcessor(struct app_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	if(ctx->num_SQ_list >= 500){
		return;
	}ctx->SQ_list[ ctx->num_SQ_list ] = * ev;
	ctx->num_SQ_list = ctx->num_SQ_list + 1;
	out->psn = -1;
	if( ev->lkey == ctx->lkey )
	{
		__u32 first_psn = 0;
		__u32 index = 0 ;
		struct loop_arg0 arg0;
		arg0.index = index;
		arg0.ev = ev;
		arg0.ctx = ctx;
		arg0.first_psn = first_psn;
		bpf_loop(100, loop_function0, &arg0, 0);
		out->psn = first_psn;
	}
	
}*/
static long loop_function1(__u32 ind, struct loop_arg1 *arg)
{
	if(!(arg->index < arg->ev->length )) {
		return 1;
	}
	struct net_metadata pkt_ev;
	pkt_ev.type_metadata = IS_NET_METADATA;
	pkt_ev.read_from_mem = 1;
	pkt_ev.address = arg->ev->addr + arg->index;
	__u32 data_len = arg->ctx->MTU;
	if( arg->index + arg->ctx->MTU < arg->ev->length )
	{
		pkt_ev.length = arg->ctx->MTU;
	}
	else
	{
		data_len = arg->ev->length - arg->index;
		pkt_ev.length = data_len;
	}
	
	//struct RETHeader reth = {};
	if( arg->index == 0 )
	{
		pkt_ev.reth.raddr = arg->ev->raddr;
		pkt_ev.reth.rkey = arg->ev->rkey;
		pkt_ev.reth.length = arg->ev->length;
	}
	
	//struct BTHeader bth = {};
	if( arg->ev->length <= arg->ctx->MTU )
	{
		pkt_ev.bth.opcode = 10;
		arg->first_psn = arg->ctx->nPSN;
	}
	else
	{
		if( ind == 0 )
		{
			pkt_ev.bth.opcode = 6;
			arg->first_psn = arg->ctx->nPSN;
		}
		else
		{
			if( arg->index + arg->ctx->MTU >= arg->ev->length )
			{
				pkt_ev.bth.opcode = 8;
			}
			else
			{
				pkt_ev.bth.opcode = 7;
			}	
		}
		
	}
	pkt_ev.bth.ack_req = arg->ev->ack_req;
	pkt_ev.bth.dest_qp = arg->ctx->dest_qp;
	pkt_ev.bth.psn = arg->ctx->nPSN;
	arg->ctx->nPSN = arg->ctx->nPSN + 1;
	//struct UDPHeader udp = {};
	pkt_ev.udp.src_port = arg->ctx->src_port;
	pkt_ev.udp.dst_port = arg->ctx->dst_port;
	pkt_ev.udp.length = 8 + sizeof( struct BTHeader ) + data_len;
	if( arg->index == 0 )
	{
		pkt_ev.hdr_combination = 0;
		pkt_ev.udp.length = pkt_ev.udp.length + sizeof( struct RETHeader );
	}
	else
	{
		pkt_ev.hdr_combination = 1;
		//pkt_ev.reth = reth;
	}
	
	//pkt_ev.udp = udp;
	//pkt_ev.bth = bth;
	struct packet_info save_packet = {};
	save_packet.pkt_ev = pkt_ev;
	save_packet.psn = pkt_ev.bth.psn;
	save_packet.ack_req = pkt_ev.bth.ack_req;
	save_packet.wr_id = arg->ev->wr_id;
	save_packet.acked = 0;
	save_packet.SSN = arg->ctx->SSN;
	arg->ctx->SSN = arg->ctx->SSN + 1;
	if(arg->ctx->num_sent_packets >= 500){
		return 1;
	}arg->ctx->sent_packets[ arg->ctx->num_sent_packets ] = save_packet;
	arg->ctx->num_sent_packets = arg->ctx->num_sent_packets + 1;
	arg->ctx->LSN = arg->ctx->LSN + 1;
	arg->index = arg->index + arg->ctx->MTU ;
	return 0;
}
static __always_inline void WriteProcessor(struct app_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	bpf_printk("WRITE");
	if(ctx->num_SQ_list >= 500){
		return;
	}
	ctx->SQ_list[ ctx->num_SQ_list ] = * ev;
	ctx->num_SQ_list = ctx->num_SQ_list + 1;
	out->psn = -1;
	if( ev->lkey == ctx->lkey )
	{
		__u32 first_psn = 0;
		__u32 index = 0 ;
		struct loop_arg1 arg1;
		arg1.index = index;
		arg1.ev = ev;
		arg1.ctx = ctx;
		arg1.first_psn = first_psn;
		bpf_loop(100, loop_function1, &arg1, 0);
		out->psn = first_psn;
	}
	
}

/*
static __always_inline void RecvProcessor(struct app_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	if(ctx->num_RQ_list >= 500){
		return;
	}ctx->RQ_list[ ctx->num_RQ_list ] = * ev;
	ctx->num_RQ_list = ctx->num_RQ_list + 1;
	ctx->credit_count = ctx->credit_count + 1;
}
static long loop_function2(__u32 index, struct loop_arg2 *arg)
{
	if(!(arg->i < (__u32)( arg->ev->length / arg->ctx->MTU ) )) {
		return 1;
	}
	struct packet_info save_packet = {};
	//save_packet.pkt_ev = arg->pkt_ev;
	//save_packet.psn = arg->bth.psn + arg->i;
	save_packet.ack_req = 1;
	save_packet.wr_id = arg->ev->wr_id;
	save_packet.acked = 0;
	save_packet.SSN = arg->ctx->SSN;
	save_packet.laddr = arg->ev->addr;
	arg->ctx->SSN = arg->ctx->SSN + 1;
	if(arg->ctx->num_sent_packets >= 500){
		return 1;
	}arg->ctx->sent_packets[ arg->ctx->num_sent_packets ] = save_packet;
	arg->ctx->num_sent_packets = arg->ctx->num_sent_packets + 1;
	arg->ctx->LSN = arg->ctx->LSN + 1;
	arg->i = arg->i + 1 ;
	return 0;
}
static __always_inline void ReadProcessor(struct app_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	if(ctx->num_SQ_list >= 500){
		return;
	}ctx->SQ_list[ ctx->num_SQ_list ] = * ev;
	ctx->num_SQ_list = ctx->num_SQ_list + 1;
	out->psn = -1;
	struct net_metadata pkt_ev;
	pkt_ev.type_metadata = IS_NET_METADATA;
	pkt_ev.read_from_mem = 0;
	pkt_ev.hdr_combination = 1;
	pkt_ev.length = 0;
	__u32 first_psn = 0;
	struct RETHeader reth = {};
	reth.raddr = ev->raddr;
	reth.rkey = ev->rkey;
	reth.length = ev->length;
	struct BTHeader bth = {};
	bth.opcode = 12;
	bth.dest_qp = ctx->dest_qp;
	bth.psn = ctx->nPSN;
	first_psn = ctx->nPSN;
	ctx->nPSN = ctx->nPSN + (__u32)( ev->length / ctx->MTU );
	struct UDPHeader udp = {};
	udp.src_port = ctx->src_port;
	udp.dst_port = ctx->dst_port;
	udp.length = 8 + sizeof( bth ) + sizeof( reth );
	pkt_ev.udp = udp;
	pkt_ev.bth = bth;
	pkt_ev.reth = reth;
	__u32 i = 0 ;
	struct loop_arg2 arg2;
	//arg2.pkt_ev = pkt_ev;
	arg2.i = i;
	//arg2.bth = bth;
	arg2.ev = ev;
	arg2.ctx = ctx;
	bpf_loop(100, loop_function2, &arg2, 0);
	out->psn = first_psn;
}
static __always_inline void AtomicProcessor(struct app_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	if(ctx->num_SQ_list >= 500){
		return;
	}ctx->SQ_list[ ctx->num_SQ_list ] = * ev;
	ctx->num_SQ_list = ctx->num_SQ_list + 1;
	out->psn = -1;
	struct net_metadata pkt_ev;
	pkt_ev.type_metadata = IS_NET_METADATA;
	pkt_ev.hdr_combination = 3;
	pkt_ev.length = 0;
	struct AtomicETHeader aeth = {};
	aeth.raddr = ev->raddr;
	aeth.rkey = ev->rkey;
	aeth.swap_add = ev->swap_add;
	aeth.compare = ev->compare;
	struct BTHeader bth = {};
	if( ev->compare == -1 )
	{
		bth.opcode = 20;
	}
	else
	{
		bth.opcode = 19;
	}
	
	bth.dest_qp = ctx->dest_qp;
	bth.psn = ctx->nPSN;
	ctx->nPSN = ctx->nPSN + 1;
	struct UDPHeader udp = {};
	udp.src_port = ctx->src_port;
	udp.dst_port = ctx->dst_port;
	udp.length = 8 + sizeof( bth ) + sizeof( aeth );
	pkt_ev.udp = udp;
	pkt_ev.bth = bth;
	//pkt_ev.atom_aeth = aeth;
	struct packet_info save_packet = {};
	save_packet.pkt_ev = pkt_ev;
	save_packet.psn = bth.psn;
	save_packet.ack_req = 1;
	save_packet.wr_id = ev->wr_id;
	save_packet.acked = 0;
	if(ctx->num_sent_packets >= 500){
		return;
	}ctx->sent_packets[ ctx->num_sent_packets ] = save_packet;
	ctx->num_sent_packets = ctx->num_sent_packets + 1;
	out->psn = ctx->nPSN - 1;
	ctx->LSN = ctx->LSN + 1;
}*/
static __always_inline void intermPSNProcessor(struct prog_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	out->psn = ev->psn;
}
static long loop_function3(__u32 index, struct loop_arg3 *arg)
{
	if(!(arg->i < arg->ctx->num_sent_packets )) {
		return 1;
	}
	if(arg->i >= 500){
		return 1;
	}
	bpf_printk("TRANSMIT LOOP: %d", arg->i);
	//struct packet_info element_list = arg->ctx->sent_packets[ arg->i ];
	//struct net_metadata pkt_ev = element_list.pkt_ev;
	//pkt_ev.type_metadata = IS_NET_METADATA;
	//arg->ctx->sent_packets[ arg->i ].pkt_ev.type_metadata = IS_NET_METADATA;
	//arg->udp = pkt_ev.udp;
	//arg->bth = pkt_ev.bth;
	if( arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.psn >= arg->out->psn )
	{
		if( !( arg->ctx->sent_packets[ arg->i ].SSN <= arg->ctx->LSN ) && ( arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 4 || arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 0 || arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 2 || arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 1 ) )
		{
			arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.ack_req = 1;
			if((void *)(long)arg->redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)arg->redirect_pkt->data_end) {
				return 1;
			}struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)arg->redirect_pkt->data;
			if(meta_hdr->metadata_end > 4000) {
				return 1;
			}if((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(struct net_metadata) > (void *)(long)arg->redirect_pkt->data_end) {
				return 1;
			}__builtin_memcpy((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end), &(arg->ctx->sent_packets[arg->i].pkt_ev), sizeof(struct net_metadata));
			meta_hdr->metadata_end += sizeof(struct net_metadata);
			arg->number_packets_sent = arg->number_packets_sent + 1;
			return 1;
		}
		
		//element_list.pkt_ev.bth = pkt_ev.bth;
		//element_list.pkt_ev.udp = pkt_ev.udp;
		if((void *)(long)arg->redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)arg->redirect_pkt->data_end) {
			return 1;
		}struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)arg->redirect_pkt->data;
		if(meta_hdr->metadata_end > 4000) {
			return 1;
		}if((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(struct net_metadata) > (void *)(long)arg->redirect_pkt->data_end) {
			return 1;
		}__builtin_memcpy((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end), &(arg->ctx->sent_packets[ arg->i ].pkt_ev), sizeof(struct net_metadata));
		meta_hdr->metadata_end += sizeof(struct net_metadata);
		arg->number_packets_sent = arg->number_packets_sent + 1;
		arg->ctx->byte_counter = arg->ctx->byte_counter + arg->ctx->sent_packets[ arg->i ].pkt_ev.length;
		if( arg->ctx->byte_counter > arg->ctx->BC )
		{
			arg->ctx->byte_counter = 0;
			arg->ctx->BC = arg->ctx->BC + 1;
			struct prog_event new_event;
			new_event.ev_flow_id = arg->ev->ev_flow_id;
			new_event.event_type = DCQCN_INCREASE;
			new_event.qp_id = arg->ev->qp_id;
			generic_event_enqueue( & new_event , PROG_EVENT );
		}
		
	}
	
	arg->i = arg->i + 1 ;
	return 0;
}
static __always_inline void TransmitProcessor_app_event(struct app_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	bpf_printk("TRANSMIT");
	if( ctx->first_pkt_connection )
	{
		struct timer_event new_event;
		new_event.ev_flow_id = ev->ev_flow_id;
		new_event.event_type = ALPHA_CHECK;
		new_event.qp_id = ev->qp_id;
		//__u32 alpha_timeout = 55;
		__u32 alpha_timeout = 550000000;
		ctx->timer_alpha.duration = 1000 * alpha_timeout;
		initialize_timer( new_event , ctx->timer_alpha.duration , timer_alpha );
		struct timer_event new_event2;
		new_event2.ev_flow_id = ev->ev_flow_id;
		new_event2.event_type = DCQCN_TIMER;
		new_event2.qp_id = ev->qp_id;
		//__u32 DCQCN_timeout = 1500;
		__u32 DCQCN_timeout = 1500000000;
		ctx->timer_DCQCN_counter.duration = 1000 * DCQCN_timeout;
		initialize_timer( new_event2 , ctx->timer_DCQCN_counter.duration , timer_DCQCN_counter );
		ctx->first_pkt_connection = 0;
	}
	
	//__u8 last_packet = 1;
	__u32 number_packets_sent = 0;
	__u32 i = 0 ;
	struct loop_arg3 arg3;
	arg3.ctx = ctx;
	arg3.i = i;
	arg3.out = out;
	arg3.redirect_pkt = redirect_pkt;
	arg3.number_packets_sent = number_packets_sent;
	arg3.ev = ev;
	bpf_loop(100, loop_function3, &arg3, 0);
	/*if( !last_packet )
	{
		struct prog_event new_event;
		new_event.ev_flow_id = ev->ev_flow_id;
		new_event.event_type = TRANSMIT_EVENT;
		new_event.wr_id = ev->wr_id;
		new_event.psn = out->psn + number_packets_sent;
		new_event.ack_req = ev->ack_req;
		generic_event_enqueue( & new_event , PROG_EVENT );
	}*/
	
	/*if( ev->ack_req )
	{
		struct timer_event timer_ev;
		timer_ev.ev_flow_id = ev->ev_flow_id;
		timer_ev.event_type = MISS_ACK;
		ctx->timer_ack_timeout.duration = 1000000000 * ctx->transport_timer;
		initialize_timer( timer_ev , ctx->timer_ack_timeout.duration , timer_ack_timeout );
	}*/
	
	return;
}
static long loop_function4(__u32 index, struct loop_arg4 *arg)
{
	if(!(arg->i < arg->ctx->num_sent_packets )) {
		return 1;
	}
	if(arg->i >= 500){
		return 1;
	}
	//struct packet_info element_list = arg->ctx->sent_packets[ arg->i ];
	//struct net_metadata pkt_ev = element_list.pkt_ev;
	//pkt_ev.type_metadata = IS_NET_METADATA;
	//arg->ctx->sent_packets[ arg->i ].pkt_ev.type_metadata = IS_NET_METADATA;
	//arg->udp = pkt_ev.udp;
	//arg->bth = pkt_ev.bth;
	if( arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.psn >= arg->out->psn )
	{
		if( !( arg->ctx->sent_packets[ arg->i ].SSN <= arg->ctx->LSN ) && ( arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 4 || arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 0 || arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 2 || arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 1 ) )
		{
			arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.ack_req = 1;
			if((void *)(long)arg->redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)arg->redirect_pkt->data_end) {
				return 1;
			}struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)arg->redirect_pkt->data;
			if(meta_hdr->metadata_end > 4000) {
				return 1;
			}if((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(struct net_metadata) > (void *)(long)arg->redirect_pkt->data_end) {
				return 1;
			}__builtin_memcpy((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end), &(arg->ctx->sent_packets[arg->i].pkt_ev), sizeof(struct net_metadata));
			meta_hdr->metadata_end += sizeof(struct net_metadata);
			arg->number_packets_sent = arg->number_packets_sent + 1;
			return 1;
		}
		
		//element_list.pkt_ev.bth = pkt_ev.bth;
		//element_list.pkt_ev.udp = pkt_ev.udp;
		if((void *)(long)arg->redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)arg->redirect_pkt->data_end) {
			return 1;
		}struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)arg->redirect_pkt->data;
		if(meta_hdr->metadata_end > 4000) {
			return 1;
		}if((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(struct net_metadata) > (void *)(long)arg->redirect_pkt->data_end) {
			return 1;
		}__builtin_memcpy((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end), &(arg->ctx->sent_packets[ arg->i ].pkt_ev), sizeof(struct net_metadata));
		meta_hdr->metadata_end += sizeof(struct net_metadata);
		arg->number_packets_sent = arg->number_packets_sent + 1;
		arg->ctx->byte_counter = arg->ctx->byte_counter + arg->ctx->sent_packets[ arg->i ].pkt_ev.length;
		if( arg->ctx->byte_counter > arg->ctx->BC )
		{
			arg->ctx->byte_counter = 0;
			arg->ctx->BC = arg->ctx->BC + 1;
			struct prog_event new_event;
			new_event.ev_flow_id = arg->ev->ev_flow_id;
			new_event.event_type = DCQCN_INCREASE;
			new_event.qp_id = arg->ev->qp_id;
			generic_event_enqueue( & new_event , PROG_EVENT );
		}
		
	}
	
	arg->i = arg->i + 1 ;
	return 0;
}
static __always_inline void TransmitProcessor_prog_event(struct prog_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	/*if( ctx->first_pkt_connection )
	{
		struct timer_event new_event;
		new_event.ev_flow_id = ev->ev_flow_id;
		new_event.event_type = ALPHA_CHECK;
		new_event.qp_id = ev->qp_id;
		__u32 alpha_timeout = 55;
		ctx->timer_alpha.duration = 1000 * alpha_timeout;
		initialize_timer( new_event , ctx->timer_alpha.duration , timer_alpha );
		struct timer_event new_event2;
		new_event2.ev_flow_id = ev->ev_flow_id;
		new_event2.event_type = DCQCN_TIMER;
		new_event2.qp_id = ev->qp_id;
		__u32 DCQCN_timeout = 1500;
		ctx->timer_DCQCN_counter.duration = 1000 * DCQCN_timeout;
		initialize_timer( new_event2 , ctx->timer_DCQCN_counter.duration , timer_DCQCN_counter );
		ctx->first_pkt_connection = 0;
	}*/
	
	//__u8 last_packet = 1;
	//struct BTHeader bth = {};
	//struct UDPHeader udp = {};
	__u32 number_packets_sent = 0;
	__u32 i = 0 ;
	struct loop_arg4 arg4;
	arg4.ctx = ctx;
	arg4.i = i;
	//arg4.udp = udp;
	//arg4.bth = bth;
	arg4.out = out;
	arg4.redirect_pkt = redirect_pkt;
	arg4.number_packets_sent = number_packets_sent;
	arg4.ev = ev;
	bpf_loop(100, loop_function4, &arg4, 0);
	/*if( !last_packet )
	{
		struct prog_event new_event;
		new_event.ev_flow_id = ev->ev_flow_id;
		new_event.event_type = TRANSMIT_EVENT;
		new_event.wr_id = ev->wr_id;
		new_event.psn = out->psn + number_packets_sent;
		new_event.ack_req = ev->ack_req;
		generic_event_enqueue( & new_event , PROG_EVENT );
	}*/
	
	/*if( ev->ack_req )
	{
		struct timer_event timer_ev;
		timer_ev.ev_flow_id = ev->ev_flow_id;
		timer_ev.event_type = MISS_ACK;
		ctx->timer_ack_timeout.duration = 1000000000 * ctx->transport_timer;
		initialize_timer( timer_ev , ctx->timer_ack_timeout.duration , timer_ack_timeout );
	}*/
	
	return;
}
static long loop_function5(__u32 index, struct loop_arg5 *arg)
{
	if(!(arg->i < arg->ctx->num_sent_packets )) {
		return 1;
	}
	if(arg->i >= 500){
		return 1;
	}
	//struct packet_info element_list = arg->ctx->sent_packets[ arg->i ];
	//struct net_metadata pkt_ev = element_list.pkt_ev;
	//pkt_ev.type_metadata = IS_NET_METADATA;
	//arg->ctx->sent_packets[ arg->i ].pkt_ev.type_metadata = IS_NET_METADATA;
	//arg->udp = pkt_ev.udp;
	//arg->bth = pkt_ev.bth;
	if( arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.psn >= arg->out->psn )
	{
		if( !( arg->ctx->sent_packets[ arg->i ].SSN <= arg->ctx->LSN ) && ( arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 4 || arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 0 || arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 2 || arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.opcode == 1 ) )
		{
			arg->ctx->sent_packets[ arg->i ].pkt_ev.bth.ack_req = 1;
			if((void *)(long)arg->redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)arg->redirect_pkt->data_end) {
				return 1;
			}struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)arg->redirect_pkt->data;
			if(meta_hdr->metadata_end > 4000) {
				return 1;
			}if((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(struct net_metadata) > (void *)(long)arg->redirect_pkt->data_end) {
				return 1;
			}__builtin_memcpy((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end), &(arg->ctx->sent_packets[arg->i].pkt_ev), sizeof(struct net_metadata));
			meta_hdr->metadata_end += sizeof(struct net_metadata);
			arg->number_packets_sent = arg->number_packets_sent + 1;
			return 1;
		}
		
		//element_list.pkt_ev.bth = pkt_ev.bth;
		//element_list.pkt_ev.udp = pkt_ev.udp;
		if((void *)(long)arg->redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)arg->redirect_pkt->data_end) {
			return 1;
		}struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)arg->redirect_pkt->data;
		if(meta_hdr->metadata_end > 4000) {
			return 1;
		}if((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(struct net_metadata) > (void *)(long)arg->redirect_pkt->data_end) {
			return 1;
		}__builtin_memcpy((void *)(long)arg->redirect_pkt->data + (meta_hdr->metadata_end), &(arg->ctx->sent_packets[ arg->i ].pkt_ev), sizeof(struct net_metadata));
		meta_hdr->metadata_end += sizeof(struct net_metadata);
		arg->number_packets_sent = arg->number_packets_sent + 1;
		arg->ctx->byte_counter = arg->ctx->byte_counter + arg->ctx->sent_packets[ arg->i ].pkt_ev.length;
		if( arg->ctx->byte_counter > arg->ctx->BC )
		{
			arg->ctx->byte_counter = 0;
			arg->ctx->BC = arg->ctx->BC + 1;
			struct prog_event new_event;
			new_event.ev_flow_id = arg->ev->ev_flow_id;
			new_event.event_type = DCQCN_INCREASE;
			new_event.qp_id = arg->ev->qp_id;
			generic_event_enqueue( & new_event , PROG_EVENT );
		}
		
	}
	
	arg->i = arg->i + 1 ;
	return 0;
}
static __always_inline void TransmitProcessor_net_event(struct net_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	/*if( ctx->first_pkt_connection )
	{
		struct timer_event new_event;
		new_event.ev_flow_id = ev->ev_flow_id;
		new_event.event_type = ALPHA_CHECK;
		new_event.qp_id = ev->qp_id;
		__u32 alpha_timeout = 55;
		ctx->timer_alpha.duration = 1000 * alpha_timeout;
		initialize_timer( new_event , ctx->timer_alpha.duration , timer_alpha );
		struct timer_event new_event2;
		new_event2.ev_flow_id = ev->ev_flow_id;
		new_event2.event_type = DCQCN_TIMER;
		new_event2.qp_id = ev->qp_id;
		__u32 DCQCN_timeout = 1500;
		ctx->timer_DCQCN_counter.duration = 1000 * DCQCN_timeout;
		initialize_timer( new_event2 , ctx->timer_DCQCN_counter.duration , timer_DCQCN_counter );
		ctx->first_pkt_connection = 0;
	}*/
	
	//__u8 last_packet = 1;
	//struct BTHeader bth = {};
	//struct UDPHeader udp = {};
	__u32 number_packets_sent = 0;
	__u32 i = 0 ;
	struct loop_arg5 arg5;
	arg5.ctx = ctx;
	arg5.i = i;
	//arg5.udp = udp;
	//arg5.bth = bth;
	arg5.out = out;
	arg5.redirect_pkt = redirect_pkt;
	arg5.number_packets_sent = number_packets_sent;
	arg5.ev = ev;
	bpf_loop(100, loop_function5, &arg5, 0);
	/*if( !last_packet )
	{
		struct prog_event new_event;
		new_event.ev_flow_id = ev->ev_flow_id;
		new_event.event_type = TRANSMIT_EVENT;
		new_event.wr_id = ev->wr_id;
		new_event.psn = out->psn + number_packets_sent;
		new_event.ack_req = ev->ack_req;
		generic_event_enqueue( & new_event , PROG_EVENT );
	}*/
	
	/*if( ev->ack_req )
	{
		struct timer_event timer_ev;
		timer_ev.ev_flow_id = ev->ev_flow_id;
		timer_ev.event_type = MISS_ACK;
		ctx->timer_ack_timeout.duration = 1000000000 * ctx->transport_timer;
		initialize_timer( timer_ev , ctx->timer_ack_timeout.duration , timer_ack_timeout );
	}*/
	
	return;
}

/*
static long loop_function6(__u32 index, struct loop_arg6 *arg)
{
	if(!(arg->i < arg->ctx->num_RQ_list - 1 )) {
		return 1;
	}
	if(arg->i >= 500 || arg->i + 1 >= 500){
		return 1;
	}arg->ctx->RQ_list[ arg->i ] = arg->ctx->RQ_list[ arg->i + 1 ];
	arg->i = arg->i + 1 ;
	return 0;
}
static __always_inline void RecvDataProcessor(struct net_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	struct app_metadata fb_new_event;
	fb_new_event.type_metadata = IS_APP_METADATA;
	fb_new_event.write_to_mem = 0;
	fb_new_event.fb_type = 1;
	fb_new_event.bytes = ev->pkt_bytes_size;
	fb_new_event.transit_addr = ev->transit_addr;
	if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end) {
		return;
	}struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
	if(meta_hdr->metadata_end > 4000) {
		return;
	}if((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(fb_new_event) > (void *)(long)redirect_pkt->data_end) {
		return;
	}__builtin_memcpy((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end), &fb_new_event, sizeof(fb_new_event));
	meta_hdr->metadata_end += sizeof(fb_new_event);
	struct net_metadata pkt_ev;
	pkt_ev.type_metadata = IS_NET_METADATA;
	pkt_ev.length = 0;
	if( ctx->credit_count > 0 )
	{
		if( ev->psn == ctx->ePSN && ( ev->opcode == 0 || ev->opcode == 4 ) )
		{
			ctx->recv_first_psn = ev->psn;
		}
		
		struct AETHeader aeth = {};
		if( ev->psn <= ctx->ePSN )
		{
			aeth.ack = 1;
			aeth.MSN = ctx->MSN;
			if( ev->psn == ctx->ePSN && ( ev->opcode == 2 || ev->opcode == 4 ) )
			{
				ctx->credit_count = ctx->credit_count - 1;
			}
			
			aeth.credit_count = ctx->credit_count;
		}
		else
		{
			aeth.ack = 0;
			aeth.type_nack = 1;
		}
		
		struct BTHeader bth = {};
		bth.opcode = 17;
		bth.dest_qp = ctx->dest_qp;
		bth.psn = ctx->ePSN;
		struct UDPHeader udp = {};
		udp.src_port = ctx->src_port;
		udp.dst_port = ctx->dst_port;
		udp.length = 8 + sizeof( bth ) + sizeof( aeth );
		pkt_ev.udp = udp;
		pkt_ev.bth = bth;
		pkt_ev.aeth = aeth;
		pkt_ev.hdr_combination = 2;
		if( ev->psn == ctx->ePSN )
		{
			ctx->ePSN = ctx->ePSN + 1;
			if(0 >= 500){
				return;
			}__u8 addr = ctx->RQ_list[ 0 ].addr;
			fb_new_event.address = addr;
			fb_new_event.offset = ev->psn - ctx->recv_first_psn;
			fb_new_event.length = ev->data_len;
			fb_new_event.write_to_mem = 1;
			if( ev->opcode == 2 || ev->opcode == 4 )
			{
				__u32 i = 0 ;
				struct loop_arg6 arg6;
				arg6.ctx = ctx;
				arg6.i = i;
				bpf_loop(100, loop_function6, &arg6, 0);
				ctx->num_RQ_list = ctx->num_RQ_list - 1;
			}
			
		}
		
		if( ev->ack_req || !aeth.ack )
		{
			struct responder_packet_info responder_info = {};
			responder_info.pkt_ev = pkt_ev;
			responder_info.wr_id = ev->wr_id;
			if(ctx->num_responder_packets >= 500){
				return;
			}ctx->responder_packets[ ctx->num_responder_packets ] = responder_info;
			ctx->num_responder_packets = ctx->num_responder_packets + 1;
			struct prog_event new_event;
			new_event.ev_flow_id = ev->ev_flow_id;
			new_event.event_type = RESPONDER_EVENT;
			new_event.qp_id = ev->qp_id;
			generic_event_enqueue( & new_event , PROG_EVENT );
		}
		
	}
	else
	{
		struct AETHeader aeth = {};
		aeth.ack = 0;
		aeth.type_nack = 0;
		struct BTHeader bth = {};
		bth.opcode = 17;
		bth.dest_qp = ctx->dest_qp;
		bth.psn = ctx->ePSN;
		struct UDPHeader udp = {};
		udp.src_port = ctx->src_port;
		udp.dst_port = ctx->dst_port;
		pkt_ev.udp = udp;
		pkt_ev.bth = bth;
		pkt_ev.aeth = aeth;
		pkt_ev.hdr_combination = 2;
		struct responder_packet_info responder_info = {};
		responder_info.pkt_ev = pkt_ev;
		responder_info.wr_id = ev->wr_id;
		if(ctx->num_responder_packets >= 500){
			return;
		}ctx->responder_packets[ ctx->num_responder_packets ] = responder_info;
		ctx->num_responder_packets = ctx->num_responder_packets + 1;
		struct prog_event new_event;
		new_event.ev_flow_id = ev->ev_flow_id;
		new_event.event_type = RESPONDER_EVENT;
		new_event.qp_id = ev->qp_id;
		generic_event_enqueue( & new_event , PROG_EVENT );
	}
	
	return;
}*/

static __always_inline void WriteDataProcessor(struct net_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	bpf_printk("WRITE_DATA");

	struct net_metadata pkt_ev;
	pkt_ev.type_metadata = IS_NET_METADATA;
	pkt_ev.length = 0;
	if( ev->psn == ctx->ePSN && ( ev->opcode == 6 || ev->opcode == 10 ) )
	{
		ctx->write_first_psn = ev->psn;
	}
	
	//struct AETHeader aeth = {};
	if( ev->psn <= ctx->ePSN )
	{
		pkt_ev.aeth.ack = 1;
		pkt_ev.aeth.MSN = ctx->MSN;
		pkt_ev.aeth.credit_count = ctx->credit_count;
	}
	else
	{
		pkt_ev.aeth.ack = 0;
		pkt_ev.aeth.type_nack = 1;
	}
	
	//struct BTHeader bth = {};
	pkt_ev.bth.opcode = 17;
	pkt_ev.bth.dest_qp = ctx->dest_qp;
	pkt_ev.bth.psn = ctx->ePSN;
	//struct UDPHeader udp = {};
	pkt_ev.udp.src_port = ctx->src_port;
	pkt_ev.udp.dst_port = ctx->dst_port;
	pkt_ev.udp.length = 8 + sizeof( struct BTHeader ) + sizeof( struct AETHeader );
	//pkt_ev.udp = udp;
	//pkt_ev.bth = bth;
	//pkt_ev.aeth = aeth;
	pkt_ev.hdr_combination = 2;
	if( ev->psn == ctx->ePSN )
	{
		ctx->ePSN = ctx->ePSN + 1;
		if(0 >= 500){
			return;
		}__u8 addr = ctx->RQ_list[ 0 ].addr;
		struct app_metadata fb_new_event;
		fb_new_event.type_metadata = IS_APP_METADATA;
		fb_new_event.address = addr;
		fb_new_event.offset = ev->psn - ctx->write_first_psn;
		fb_new_event.length = ev->data_len;
		fb_new_event.write_to_mem = 1;
		if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end) {
			return;
		}struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
		if(meta_hdr->metadata_end > 4000) {
			return;
		}if((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(fb_new_event) > (void *)(long)redirect_pkt->data_end) {
			return;
		}__builtin_memcpy((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end), &fb_new_event, sizeof(fb_new_event));
		meta_hdr->metadata_end += sizeof(fb_new_event);
	}
	
	if( ev->ack_req )
	{
		struct responder_packet_info responder_info = {};
		responder_info.pkt_ev = pkt_ev;
		responder_info.wr_id = ev->wr_id;
		if(ctx->num_responder_packets >= 500){
			return;
		}ctx->responder_packets[ ctx->num_responder_packets ] = responder_info;
		ctx->num_responder_packets = ctx->num_responder_packets + 1;
		struct prog_event new_event;
		new_event.ev_flow_id = ev->ev_flow_id;
		new_event.event_type = RESPONDER_EVENT;
		new_event.qp_id = ev->qp_id;
		generic_event_enqueue( & new_event , PROG_EVENT );
	}
	
	return;
}

/*static long loop_function7(__u32 index, struct loop_arg7 *arg)
{
	if(!(arg->index < arg->ev->pkt_bytes_size )) {
		return 1;
	}
	//__u32 data_len = arg->ctx->MTU;
	//arg->pkt_ev.address = arg->ev->raddr + arg->index;
	if( arg->index + arg->ctx->MTU < arg->ev->pkt_bytes_size )
	{
		//arg->pkt_ev.length = arg->ctx->MTU;
	}
	else
	{
		//data_len = arg->ev->pkt_bytes_size - arg->index;
		//arg->pkt_ev.length = data_len;
	}
	
	//arg->aeth.ack = 1;
	//arg->aeth.MSN = arg->ctx->MSN;
	//arg->aeth.credit_count = arg->ctx->credit_count;
	if( arg->ev->pkt_bytes_size <= arg->ctx->MTU )
	{
		//arg->bth.opcode = 16;
		arg->last_packet = 1;
	}
	else
	{
		if( arg->index == 0 )
		{
			//arg->bth.opcode = 13;
		}
		else
		{
			if( arg->index + arg->ctx->MTU >= arg->ev->pkt_bytes_size )
			{
				//arg->bth.opcode = 15;
				arg->last_packet = 1;
			}
			else
			{
				//arg->bth.opcode = 14;
			}
			
		}
		
	}
	
	//arg->bth.dest_qp = arg->ctx->dest_qp;
	//arg->bth.psn = arg->ctx->ePSN;
	struct UDPHeader udp = {};
	udp.src_port = arg->ctx->src_port;
	udp.dst_port = arg->ctx->dst_port;
	if( 1 != 14 )
	{
		//udp.length = 8 + sizeof( arg->bth ) + sizeof( arg->aeth ) + data_len;
		//arg->pkt_ev.aeth = arg->aeth;
		//arg->pkt_ev.hdr_combination = 2;
	}
	else
	{
		//udp.length = 8 + sizeof( arg->bth ) + data_len;
		//arg->pkt_ev.hdr_combination = 0;
	}
	
	//arg->pkt_ev.udp = udp;
	//arg->pkt_ev.bth = arg->bth;
	struct responder_packet_info responder_info = {};
	//responder_info.pkt_ev = arg->pkt_ev;
	responder_info.wr_id = arg->ev->wr_id;
	if(arg->ctx->num_responder_packets >= 500){
		return 1;
	}arg->ctx->responder_packets[ arg->ctx->num_responder_packets ] = responder_info;
	arg->ctx->num_responder_packets = arg->ctx->num_responder_packets + 1;
	arg->ctx->ePSN = arg->ctx->ePSN + 1;
	arg->index = arg->index + arg->ctx->MTU ;
	return 0;
}
static __always_inline void ReadReqProcessor(struct net_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	struct net_metadata pkt_ev;
	pkt_ev.type_metadata = IS_NET_METADATA;
	struct AETHeader aeth = {};
	struct BTHeader bth = {};
	if( ev->psn == ctx->ePSN )
	{
		//__u8 last_packet = 0;
		__u32 index = 0 ;
		struct loop_arg7 arg7;
		arg7.ctx = ctx;
		//arg7.pkt_ev = pkt_ev;
		arg7.index = index;
		arg7.ev = ev;
		//arg7.aeth = aeth;
		//arg7.bth = bth;
		arg7.last_packet = last_packet;
		bpf_loop(100, loop_function7, &arg7, 0);
		struct prog_event new_event;
		new_event.ev_flow_id = ev->ev_flow_id;
		new_event.event_type = RESPONDER_EVENT;
		new_event.qp_id = ev->qp_id;
		generic_event_enqueue( & new_event , PROG_EVENT );
	}
	else
	{
		if( ev->psn < ctx->ePSN )
		{
			aeth.ack = 1;
			aeth.MSN = ctx->MSN;
			aeth.credit_count = ctx->credit_count;
			bth.opcode = 17;
			bth.dest_qp = ctx->dest_qp;
			bth.psn = ctx->ePSN;
			struct UDPHeader udp = {};
			udp.src_port = ctx->src_port;
			udp.dst_port = ctx->dst_port;
			udp.length = 8 + sizeof( bth ) + sizeof( aeth );
			pkt_ev.udp = udp;
			pkt_ev.bth = bth;
			pkt_ev.aeth = aeth;
			pkt_ev.hdr_combination = 2;
			struct responder_packet_info responder_info = {};
			responder_info.pkt_ev = pkt_ev;
			responder_info.wr_id = ev->wr_id;
			if(ctx->num_responder_packets >= 500){
				return;
			}ctx->responder_packets[ ctx->num_responder_packets ] = responder_info;
			ctx->num_responder_packets = ctx->num_responder_packets + 1;
			struct prog_event new_event;
			new_event.ev_flow_id = ev->ev_flow_id;
			new_event.event_type = RESPONDER_EVENT;
			new_event.qp_id = ev->qp_id;
			generic_event_enqueue( & new_event , PROG_EVENT );
		}
		else
		{
			aeth.ack = 0;
			aeth.type_nack = 1;
			bth.opcode = 17;
			bth.dest_qp = ctx->dest_qp;
			bth.psn = ctx->ePSN;
			struct UDPHeader udp = {};
			udp.src_port = ctx->src_port;
			udp.dst_port = ctx->dst_port;
			udp.length = 8 + sizeof( bth ) + sizeof( aeth );
			pkt_ev.udp = udp;
			pkt_ev.bth = bth;
			pkt_ev.aeth = aeth;
			pkt_ev.hdr_combination = 2;
			struct responder_packet_info responder_info = {};
			responder_info.pkt_ev = pkt_ev;
			responder_info.wr_id = ev->wr_id;
			if(ctx->num_responder_packets >= 500){
				return;
			}ctx->responder_packets[ ctx->num_responder_packets ] = responder_info;
			ctx->num_responder_packets = ctx->num_responder_packets + 1;
			struct prog_event new_event;
			new_event.ev_flow_id = ev->ev_flow_id;
			new_event.event_type = RESPONDER_EVENT;
			new_event.qp_id = ev->qp_id;
			generic_event_enqueue( & new_event , PROG_EVENT );
		}
		
	}
	
	return;
}
static long loop_function8(__u32 index, struct loop_arg8 *arg)
{
	if(!(arg->i < arg->ctx->num_sent_packets )) {
		return 1;
	}
	if(arg->i >= 500){
		return 1;
	}struct packet_info packet = arg->ctx->sent_packets[ arg->i ];
	if( packet.ack_req )
	{
		arg->psn_ack_req = packet.psn;
		return 1;
	}
	else
	{
		if( packet.psn > arg->ev->psn )
		{
			return 1;
		}
		
	}
	
	arg->pkt_counter = arg->pkt_counter + 1;
	arg->i = arg->i + 1 ;
	return 0;
}
static long loop_function9(__u32 index, struct loop_arg9 *arg)
{
	if(!(arg->i < arg->ctx->num_sent_packets - arg->pkt_counter )) {
		return 1;
	}
	if(arg->i >= 500 || arg->i + arg->pkt_counter >= 500){
		return 1;
	}arg->ctx->sent_packets[ arg->i ] = arg->ctx->sent_packets[ arg->i + arg->pkt_counter ];
	arg->i = arg->i + 1 ;
	return 0;
}
static long loop_function10(__u32 index, struct loop_arg10 *arg)
{
	if(!(arg->i < arg->ctx->num_sent_packets )) {
		return 1;
	}
	if(arg->i >= 500){
		return 1;
	}struct packet_info packet = arg->ctx->sent_packets[ arg->i ];
	if( packet.ack_req )
	{
		restart_timer( arg->ev->ev_flow_id , arg->ctx->timer_ack_timeout.duration , timer_ack_timeout );
		return 1;
	}
	
	arg->i = arg->i + 1 ;
	return 0;
}
static __always_inline void ReadRespProcessor(struct net_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	out->pkt_counter = 0;
	struct app_metadata fb_new_event;
	fb_new_event.type_metadata = IS_APP_METADATA;
	fb_new_event.write_to_mem = 0;
	fb_new_event.fb_type = 1;
	fb_new_event.bytes = ev->pkt_bytes_size;
	fb_new_event.transit_addr = ev->transit_addr;
	if(0 >= 500){
		return;
	}if( ev->psn >= ctx->sent_packets[ 0 ].psn )
	{
		if(0 >= 500){
			return;
		}if( ev->psn == ctx->sent_packets[ 0 ].psn )
		{
			cancel_timer( ev->ev_flow_id , timer_ack_timeout );
		}
		
		__u32 pkt_counter = 0;
		__u32 psn_ack_req = ev->psn;
		__u32 i = 0 ;
		struct loop_arg8 arg8;
		arg8.ctx = ctx;
		arg8.i = i;
		arg8.psn_ack_req = psn_ack_req;
		arg8.ev = ev;
		arg8.pkt_counter = pkt_counter;
		bpf_loop(100, loop_function8, &arg8, 0);
		if( psn_ack_req != ev->psn )
		{
			struct prog_event new_event;
			new_event.ev_flow_id = ev->ev_flow_id;
			new_event.event_type = TRANSMIT_EVENT;
			new_event.psn = psn_ack_req;
			new_event.ack_req = 1;
			generic_event_enqueue( & new_event , PROG_EVENT );
		}
		else
		{
			if(pkt_counter >= 500){
				return;
			}struct BTHeader bth = ctx->sent_packets[ pkt_counter ].pkt_ev.bth;
			if(pkt_counter >= 500){
				return;
			}__u8 addr = ctx->sent_packets[ pkt_counter ].laddr;
			fb_new_event.address = addr;
			fb_new_event.offset = ev->psn - bth.psn;
			fb_new_event.length = ev->data_len;
			fb_new_event.write_to_mem = 1;
		}
		
		i = 0 ;
		struct loop_arg9 arg9;
		arg9.ctx = ctx;
		arg9.i = i;
		arg9.pkt_counter = pkt_counter;
		bpf_loop(100, loop_function9, &arg9, 0);
		ctx->num_sent_packets = ctx->num_sent_packets - pkt_counter;
		i = 0 ;
		struct loop_arg10 arg10;
		arg10.ctx = ctx;
		arg10.i = i;
		arg10.ev = ev;
		bpf_loop(100, loop_function10, &arg10, 0);
		out->pkt_counter = pkt_counter;
	}
	
	if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end) {
		return;
	}struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
	if(meta_hdr->metadata_end > 4000) {
		return;
	}if((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(fb_new_event) > (void *)(long)redirect_pkt->data_end) {
		return;
	}__builtin_memcpy((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end), &fb_new_event, sizeof(fb_new_event));
	meta_hdr->metadata_end += sizeof(fb_new_event);
	return;
}
static __always_inline void AtomicDataProcessor(struct net_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	struct net_metadata pkt_ev;
	pkt_ev.type_metadata = IS_NET_METADATA;
	pkt_ev.length = 0;
	struct AETHeader aeth = {};
	struct BTHeader bth = {};
	if( ev->psn == ctx->ePSN )
	{
		struct prog_event new_ev;
		new_ev.ev_flow_id = ev->ev_flow_id;
		new_ev.event_type = ATOMIC_ACK;
		new_ev.length = ev->length;
		generic_event_enqueue( & new_ev , PROG_EVENT );
	}
	else
	{
		if( ev->psn < ctx->ePSN )
		{
			aeth.ack = 1;
			aeth.MSN = ctx->MSN;
			aeth.credit_count = ctx->credit_count;
			bth.opcode = 17;
			bth.dest_qp = ctx->dest_qp;
			bth.psn = ctx->ePSN;
			struct UDPHeader udp = {};
			udp.src_port = ctx->src_port;
			udp.dst_port = ctx->dst_port;
			udp.length = 8 + sizeof( bth ) + sizeof( aeth );
			pkt_ev.udp = udp;
			pkt_ev.bth = bth;
			pkt_ev.aeth = aeth;
			pkt_ev.hdr_combination = 2;
			struct responder_packet_info responder_info = {};
			responder_info.pkt_ev = pkt_ev;
			responder_info.wr_id = ev->wr_id;
			if(ctx->num_responder_packets >= 500){
				return;
			}ctx->responder_packets[ ctx->num_responder_packets ] = responder_info;
			ctx->num_responder_packets = ctx->num_responder_packets + 1;
			struct prog_event new_event;
			new_event.ev_flow_id = ev->ev_flow_id;
			new_event.event_type = RESPONDER_EVENT;
			new_event.qp_id = ev->qp_id;
			generic_event_enqueue( & new_event , PROG_EVENT );
		}
		else
		{
			aeth.ack = 0;
			aeth.type_nack = 1;
			bth.opcode = 17;
			bth.dest_qp = ctx->dest_qp;
			bth.psn = ctx->ePSN;
			struct UDPHeader udp = {};
			udp.src_port = ctx->src_port;
			udp.dst_port = ctx->dst_port;
			udp.length = 8 + sizeof( bth ) + sizeof( aeth );
			pkt_ev.udp = udp;
			pkt_ev.bth = bth;
			pkt_ev.aeth = aeth;
			struct responder_packet_info responder_info = {};
			responder_info.pkt_ev = pkt_ev;
			responder_info.wr_id = ev->wr_id;
			if(ctx->num_responder_packets >= 500){
				return;
			}ctx->responder_packets[ ctx->num_responder_packets ] = responder_info;
			ctx->num_responder_packets = ctx->num_responder_packets + 1;
			struct prog_event new_event;
			new_event.ev_flow_id = ev->ev_flow_id;
			new_event.event_type = RESPONDER_EVENT;
			new_event.qp_id = ev->qp_id;
			generic_event_enqueue( & new_event , PROG_EVENT );
		}
		
	}
	
	return;
}
static __always_inline void AtomicAckProcessor(struct prog_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	struct net_metadata pkt_ev;
	pkt_ev.type_metadata = IS_NET_METADATA;
	pkt_ev.length = 0;
	pkt_ev.length = ev->length;
	pkt_ev.hdr_combination = 4;
	struct AtomicAckETHeader atomicACKeth = {};
	struct AETHeader aeth = {};
	struct BTHeader bth = {};
	struct UDPHeader udp = {};
	atomicACKeth.original_data = 0;
	aeth.ack = 1;
	aeth.MSN = ctx->MSN;
	aeth.credit_count = ctx->credit_count;
	bth.opcode = 18;
	bth.dest_qp = ctx->dest_qp;
	bth.psn = ctx->ePSN;
	udp.src_port = ctx->src_port;
	udp.dst_port = ctx->dst_port;
	udp.length = 8 + sizeof( bth ) + sizeof( aeth ) + sizeof( atomicACKeth );
	pkt_ev.udp = udp;
	pkt_ev.bth = bth;
	pkt_ev.aeth = aeth;
	//pkt_ev.atom_ack_eth = atomicACKeth;
	struct responder_packet_info responder_info = {};
	responder_info.pkt_ev = pkt_ev;
	responder_info.wr_id = ev->wr_id;
	if(ctx->num_responder_packets >= 500){
		return;
	}ctx->responder_packets[ ctx->num_responder_packets ] = responder_info;
	ctx->num_responder_packets = ctx->num_responder_packets + 1;
	struct prog_event new_event;
	new_event.ev_flow_id = ev->ev_flow_id;
	new_event.event_type = RESPONDER_EVENT;
	new_event.qp_id = ev->qp_id;
	generic_event_enqueue( & new_event , PROG_EVENT );
	if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end) {
		return;
	}struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
	if(meta_hdr->metadata_end > 4000) {
		return;
	}if((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(pkt_ev) > (void *)(long)redirect_pkt->data_end) {
		return;
	}__builtin_memcpy((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end), &pkt_ev, sizeof(pkt_ev));
	meta_hdr->metadata_end += sizeof(pkt_ev);
	ctx->ePSN = ctx->ePSN + 1;
	return;
}*/
/*static __always_inline void MissAckProcessor(struct timer_event *ev, struct context *ctx, struct interm_out *out, struct xdp_md *redirect_pkt)
{
	if( ctx->num_sent_packets > 0 )
	{
		if(0 >= 500){
			return;
		}struct net_metadata pkt_ev = ctx->sent_packets[ 0 ].pkt_ev;
		pkt_ev.type_metadata = IS_NET_METADATA;
		if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end) {
			return;
		}struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
		if(meta_hdr->metadata_end > 4000) {
			return;
		}if((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end) + sizeof(pkt_ev) > (void *)(long)redirect_pkt->data_end) {
			return;
		}__builtin_memcpy((void *)(long)redirect_pkt->data + (meta_hdr->metadata_end), &pkt_ev, sizeof(pkt_ev));
		meta_hdr->metadata_end += sizeof(pkt_ev);
		restart_timer( ev->ev_flow_id , ctx->timer_ack_timeout.duration , timer_ack_timeout );
	}	
}*/

static __always_inline void app_event_dispatcher(struct app_event* event,
struct context *ctx, struct xdp_md *redirect_pkt) {
	struct interm_out inter_output;
	switch (event->event_type)
	{
	case ATOMIC_WQE:
		//AtomicProcessor(event, ctx, &inter_output, redirect_pkt);
		TransmitProcessor_app_event(event, ctx, &inter_output, redirect_pkt);
		break;
	case READ_WQE:
		//ReadProcessor(event, ctx, &inter_output, redirect_pkt);
		TransmitProcessor_app_event(event, ctx, &inter_output, redirect_pkt);
		break;
	case RECV_WQE:
		//RecvProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	case SEND_WQE:
		//SendProcessor(event, ctx, &inter_output, redirect_pkt);
		TransmitProcessor_app_event(event, ctx, &inter_output, redirect_pkt);
		break;
	case WRITE_WQE:
		WriteProcessor(event, ctx, &inter_output, redirect_pkt);
		TransmitProcessor_app_event(event, ctx, &inter_output, redirect_pkt);
		break;
	default:
		break;
	}
}
static __always_inline void net_event_dispatcher(struct net_event* event,
struct context *ctx, struct xdp_md *redirect_pkt) {
	struct interm_out inter_output;
	switch (event->event_type)
	{
	case ACK:
		//AckProcessor(event, ctx, &inter_output, redirect_pkt);
		//RemoveSQProcessor_net_event(event, ctx, &inter_output, redirect_pkt);
		break;
	case ATOMIC_DATA:
		//CnpCheckProcessor_net_event(event, ctx, &inter_output, redirect_pkt);
		//AtomicDataProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	case CNP:
		//CnpRateProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	case NACK:
		//NackProcessor(event, ctx, &inter_output, redirect_pkt);
		//RemoveSQProcessor_net_event(event, ctx, &inter_output, redirect_pkt);
		TransmitProcessor_net_event(event, ctx, &inter_output, redirect_pkt);
		break;
	case READ_REQ_DATA:
		//CnpCheckProcessor_net_event(event, ctx, &inter_output, redirect_pkt);
		//ReadReqProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	case READ_RESP_DATA:
		//ReadRespProcessor(event, ctx, &inter_output, redirect_pkt);
		//RemoveSQProcessor_net_event(event, ctx, &inter_output, redirect_pkt);
		cancel_timer(5, 1);
		restart_timer(1, 2, 3);
		break;
	case RECV_DATA:
		//CnpCheckProcessor_net_event(event, ctx, &inter_output, redirect_pkt);
		//RecvDataProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	case WRITE_DATA:
		//CnpCheckProcessor_net_event(event, ctx, &inter_output, redirect_pkt);
		WriteDataProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	default:
		break;
	}
}
static __always_inline void timer_event_dispatcher(struct timer_event* event,
struct context *ctx, struct xdp_md *redirect_pkt) {
	//struct interm_out inter_output;
	switch (event->event_type)
	{
	case ALPHA_CHECK:
		//AlphaCheckProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	case CNP_CHECK:
		//CnpRepeatProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	case DCQCN_TIMER:
		//DcqcnTimerProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	case MISS_ACK:
		//MissAckProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	default:
		break;
	}
}
static __always_inline void prog_event_dispatcher(struct prog_event* event,
struct context *ctx, struct xdp_md *redirect_pkt) {
	struct interm_out inter_output;
	switch (event->event_type)
	{
	case ATOMIC_ACK:
		//AtomicAckProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	case DCQCN_INCREASE:
		//DcqcnIncreaseProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	case RESPONDER_EVENT:
		//ResponderProcessor(event, ctx, &inter_output, redirect_pkt);
		break;
	case TRANSMIT_EVENT:
		intermPSNProcessor(event, ctx, &inter_output, redirect_pkt);
		TransmitProcessor_prog_event(event, ctx, &inter_output, redirect_pkt);
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
        app_event_dispatcher(ev, arg->ctx, arg->redirect_pkt);
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
        timer_event_dispatcher(ev, arg->ctx, arg->redirect_pkt);
        break;
    }
    
    case PROG_EVENT:
    {
        //bpf_printk("PROG_EVENT IS THE LARGEST");
        struct prog_event *ev = prog_event_dequeue(arg->f_id,
            &(arg->f_info->prog_info.len_prog_queue), &(arg->f_info->prog_info.prog_head));
        if(!ev)
            return 1;
        prog_event_dispatcher(ev, arg->ctx, arg->redirect_pkt);
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

    //bpf_printk("%d", pkt_counter);
    /*pkt_counter++;
    //if(pkt_counter > 99998 && pkt_counter < 100000)
    //    return 0;
    if(pkt_counter == 1)
        return 0;
    if(pkt_counter == 5)
        pkt_counter = 0;*/

    *f_id = net_ev[0].ev_flow_id;
    *flow_context = retrieve_ctx(*f_id);
    if(!(*flow_context)) {
        bpf_printk("net_ev_process: Couldn't retrive ctx");
        return 0;
    }

    // Saving cwnd_size to metadata_hdr (measure at userspace)
    /*if((void *)(long)redirect_pkt->data + sizeof(struct metadata_hdr) > (void *)(long)redirect_pkt->data_end)
        return 0;
    struct metadata_hdr *meta_hdr = (struct metadata_hdr *)(long)redirect_pkt->data;
    meta_hdr->cwnd_size = (*flow_context)->cwnd_size;*/

    if(ret == 1 || ret == 2 || ret == 3) // One network packet
    	net_event_dispatcher(&net_ev[0], *flow_context, redirect_pkt);
    /*if(ret == 2) { // Two network packets
        net_event_dispatcher(&net_ev[0], *flow_context, redirect_pkt);
        net_event_dispatcher(&net_ev[1], *flow_context, redirect_pkt);
    }*/

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


