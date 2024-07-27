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
} inner_app_array0 SEC(".maps"), inner_app_array1 SEC(".maps"), inner_app_array2 SEC(".maps"), inner_app_array3 SEC(".maps"),
inner_app_array4 SEC(".maps"), inner_app_array5 SEC(".maps"), inner_app_array6 SEC(".maps"), inner_app_array7 SEC(".maps"),
inner_app_array8 SEC(".maps"), inner_app_array9 SEC(".maps"), inner_app_array10 SEC(".maps"), inner_app_array11 SEC(".maps"),
inner_app_array12 SEC(".maps"), inner_app_array13 SEC(".maps"), inner_app_array14 SEC(".maps"), inner_app_array15 SEC(".maps"),
inner_app_array16 SEC(".maps"), inner_app_array17 SEC(".maps"), inner_app_array18 SEC(".maps"), inner_app_array19 SEC(".maps");

struct outer_app_hash {
    __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
    __type(key, struct flow_id);
    __uint(max_entries, MAX_NUMBER_FLOWS);
    __array(values, struct inner_app_array);
} outer_app_hash SEC(".maps") = {
    .values = {
        [0] = &inner_app_array0, [1] = &inner_app_array1, [2] = &inner_app_array2, [3] = &inner_app_array3, [4] = &inner_app_array4,
        [5] = &inner_app_array5, [6] = &inner_app_array6, [7] = &inner_app_array7, [8] = &inner_app_array8, [9] = &inner_app_array9,
        [10] = &inner_app_array10, [11] = &inner_app_array11, [12] = &inner_app_array12, [13] = &inner_app_array13, [14] = &inner_app_array14,
        [15] = &inner_app_array15, [16] = &inner_app_array16, [17] = &inner_app_array17, [18] = &inner_app_array18, [19] = &inner_app_array19,
    },
};

struct {
    __uint(type, BPF_MAP_TYPE_HASH);
    __type(key, struct flow_id);
    __type(value, __u32);
    __uint(max_entries, MAX_NUMBER_FLOWS);
} tail_app_hash SEC(".maps");

/*--------------- TIMER EVENT MAPS ---------------*/

struct inner_timer_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct timer_event);
    __uint(max_entries, MAX_EVENT_QUEUE_LEN);
} inner_timer_array0 SEC(".maps"), inner_timer_array1 SEC(".maps"), inner_timer_array2 SEC(".maps"), inner_timer_array3 SEC(".maps"),
inner_timer_array4 SEC(".maps"), inner_timer_array5 SEC(".maps"), inner_timer_array6 SEC(".maps"), inner_timer_array7 SEC(".maps"),
inner_timer_array8 SEC(".maps"), inner_timer_array9 SEC(".maps"), inner_timer_array10 SEC(".maps"), inner_timer_array11 SEC(".maps"),
inner_timer_array12 SEC(".maps"), inner_timer_array13 SEC(".maps"), inner_timer_array14 SEC(".maps"), inner_timer_array15 SEC(".maps"),
inner_timer_array16 SEC(".maps"), inner_timer_array17 SEC(".maps"), inner_timer_array18 SEC(".maps"), inner_timer_array19 SEC(".maps");

struct outer_timer_hash {
    __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
    __type(key, struct flow_id);
    __uint(max_entries, MAX_NUMBER_FLOWS);
    __array(values, struct inner_timer_array);
} outer_timer_hash SEC(".maps") = {
    .values = {
        [0] = &inner_timer_array0, [1] = &inner_timer_array1, [2] = &inner_timer_array2, [3] = &inner_timer_array3, [4] = &inner_timer_array4,
        [5] = &inner_timer_array5, [6] = &inner_timer_array6, [7] = &inner_timer_array7, [8] = &inner_timer_array8, [9] = &inner_timer_array9,
        [10] = &inner_timer_array10, [11] = &inner_timer_array11, [12] = &inner_timer_array12, [13] = &inner_timer_array13, [14] = &inner_timer_array14,
        [15] = &inner_timer_array15, [16] = &inner_timer_array16, [17] = &inner_timer_array17, [18] = &inner_timer_array18, [19] = &inner_timer_array19,
    },
};


/*--------------- PROG EVENT MAPS ---------------*/

struct inner_prog_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct prog_event);
    __uint(max_entries, MAX_EVENT_QUEUE_LEN);
} inner_prog_array0 SEC(".maps"), inner_prog_array1 SEC(".maps"), inner_prog_array2 SEC(".maps"), inner_prog_array3 SEC(".maps"),
inner_prog_array4 SEC(".maps"), inner_prog_array5 SEC(".maps"), inner_prog_array6 SEC(".maps"), inner_prog_array7 SEC(".maps"),
inner_prog_array8 SEC(".maps"), inner_prog_array9 SEC(".maps"), inner_prog_array10 SEC(".maps"), inner_prog_array11 SEC(".maps"),
inner_prog_array12 SEC(".maps"), inner_prog_array13 SEC(".maps"), inner_prog_array14 SEC(".maps"), inner_prog_array15 SEC(".maps"),
inner_prog_array16 SEC(".maps"), inner_prog_array17 SEC(".maps"), inner_prog_array18 SEC(".maps"), inner_prog_array19 SEC(".maps");

struct outer_prog_hash {
    __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
    __type(key, struct flow_id);
    __uint(max_entries, MAX_NUMBER_FLOWS);
    __array(values, struct inner_prog_array);
} outer_prog_hash SEC(".maps") = {
    .values = {
        [0] = &inner_prog_array0, [1] = &inner_prog_array1, [2] = &inner_prog_array2, [3] = &inner_prog_array3, [4] = &inner_prog_array4,
        [5] = &inner_prog_array5, [6] = &inner_prog_array6, [7] = &inner_prog_array7, [8] = &inner_prog_array8, [9] = &inner_prog_array9,
        [10] = &inner_prog_array10, [11] = &inner_prog_array11, [12] = &inner_prog_array12, [13] = &inner_prog_array13, [14] = &inner_prog_array14,
        [15] = &inner_prog_array15, [16] = &inner_prog_array16, [17] = &inner_prog_array17, [18] = &inner_prog_array18, [19] = &inner_prog_array19,
    },
};

/*--------------- FLOW INFO MAPS ---------------*/

struct inner_flow_info_hash{
    __uint(type, BPF_MAP_TYPE_HASH);
    __type(key, struct flow_id);
    __type(value, struct flow_info);
    __uint(max_entries, MAX_NUMBER_FLOWS);
} inner_flow_info_hash0 SEC(".maps"), inner_flow_info_hash1 SEC(".maps"),inner_flow_info_hash2 SEC(".maps"),
inner_flow_info_hash3 SEC(".maps"), inner_flow_info_hash4 SEC(".maps"),inner_flow_info_hash5 SEC(".maps"),
inner_flow_info_hash6 SEC(".maps"), inner_flow_info_hash7 SEC(".maps");

struct outer_flow_info_array {
    __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
    __uint(max_entries, MAX_NUMBER_CORES);
    __type(key, __u32);
    __array(values, struct inner_flow_info_hash);
} outer_flow_info_array SEC(".maps") = {
    .values = {&inner_flow_info_hash0, &inner_flow_info_hash1, &inner_flow_info_hash2,
    &inner_flow_info_hash3, &inner_flow_info_hash4, &inner_flow_info_hash5,
    &inner_flow_info_hash6, &inner_flow_info_hash7}
};

/*--------------- TIMER TRIGGER MAP ---------------*/

struct timer_trigger_inner_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct timer_trigger);
    __uint(max_entries, MAX_NUMBER_TIMERS);
}  timer_trigger_inner_array0 SEC(".maps"), timer_trigger_inner_array1 SEC(".maps"), timer_trigger_inner_array2 SEC(".maps"), timer_trigger_inner_array3 SEC(".maps"),
timer_trigger_inner_array4 SEC(".maps"), timer_trigger_inner_array5 SEC(".maps"), timer_trigger_inner_array6 SEC(".maps"), timer_trigger_inner_array7 SEC(".maps"),
timer_trigger_inner_array8 SEC(".maps"), timer_trigger_inner_array9 SEC(".maps"), timer_trigger_inner_array10 SEC(".maps"), timer_trigger_inner_array11 SEC(".maps"),
timer_trigger_inner_array12 SEC(".maps"), timer_trigger_inner_array13 SEC(".maps"), timer_trigger_inner_array14 SEC(".maps"), timer_trigger_inner_array15 SEC(".maps"),
timer_trigger_inner_array16 SEC(".maps"), timer_trigger_inner_array17 SEC(".maps"), timer_trigger_inner_array18 SEC(".maps"), timer_trigger_inner_array19 SEC(".maps");

struct timer_trigger_outer_hash {
    __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
    __type(key, struct flow_id);
    __uint(max_entries, MAX_NUMBER_FLOWS);
    __array(values, struct timer_trigger_inner_array);
} timer_trigger_outer_hash SEC(".maps") = {
    .values = {
        [0] = &timer_trigger_inner_array0, [1] = &timer_trigger_inner_array1, [2] = &timer_trigger_inner_array2, [3] = &timer_trigger_inner_array3, [4] = &timer_trigger_inner_array4,
        [5] = &timer_trigger_inner_array5, [6] = &timer_trigger_inner_array6, [7] = &timer_trigger_inner_array7, [8] = &timer_trigger_inner_array8, [9] = &timer_trigger_inner_array9,
        [10] = &timer_trigger_inner_array10, [11] = &timer_trigger_inner_array11, [12] = &timer_trigger_inner_array12, [13] = &timer_trigger_inner_array13, [14] = &timer_trigger_inner_array14,
        [15] = &timer_trigger_inner_array15, [16] = &timer_trigger_inner_array16, [17] = &timer_trigger_inner_array17, [18] = &timer_trigger_inner_array18, [19] = &timer_trigger_inner_array19,
    },
};

/*--------------- CONTEXT HASH MAP ---------------*/

struct {
    __uint(type, BPF_MAP_TYPE_HASH);
    __type(key, struct flow_id);
    __type(value, struct context);
    __uint(max_entries, MAX_NUMBER_FLOWS);
} context_hash SEC(".maps");

/*--------------- WINDOW ARRAY ---------------*/

#define WINDOW_SIZE 5
struct
{
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __uint(max_entries, WINDOW_SIZE);
    __type(key, __u32);
    __type(value, struct packet_event);
} window_packets SEC(".maps");

static __always_inline int initialize_timer(struct timer_event, __u64, enum timer_instances);


// Note: make this function more complex in the future
static __always_inline void define_minor_type(struct net_event *net_ev) {
    net_ev->event_type = ACK;
}

// TODO: implement the hash map
static __always_inline int parse_packet(struct xdp_md *ctx, struct net_event *net_ev) {
    void *data_end = (void *)(long)ctx->data_end;
    void *data     = (void *)(long)ctx->data;

    /*bpf_xdp_adjust_tail(ctx, 3440);

    data_end = (void *)(long)ctx->data_end;
    data     = (void *)(long)ctx->data;

    bpf_printk("\n%d %d", data, data_end);
    bpf_printk("%d\n", data_end - data);*/

    //bpf_printk("\nRX queue index: %u", ctx->rx_queue_index);

    struct ethhdr *eth;
    struct iphdr *iphdr;
    struct tcphdr *tcph;

    struct hdr_cursor nh;
    int eth_type, ip_type;

    nh.pos = data;

    eth_type = parse_ethhdr(&nh, data_end, &eth);
    if (eth_type != bpf_htons(ETH_P_IP)) {
        //bpf_printk("\nDropped at eth. Type: %x\n\n", bpf_ntohs(eth_type));
        return 0;
    }


    //bpf_printk("\nSource MAC p1: %x:%x:%x",
    //           eth->h_source[0], eth->h_source[1], eth->h_source[2]);
    //bpf_printk("\nSource MAC p2: %x:%x:%x",
    //           eth->h_source[3], eth->h_source[4], eth->h_source[5]);

    //bpf_printk("\nDest MAC p1: %x:%x:%x",
    //           eth->h_dest[0], eth->h_dest[1], eth->h_dest[2]);
    //bpf_printk("\nDest MAC p2: %x:%x:%x",
    //           eth->h_dest[3], eth->h_dest[4], eth->h_dest[5]);
    //bpf_printk("\nEtherType: %x", bpf_ntohs(eth->h_proto));

    ip_type = parse_iphdr(&nh, data_end, &iphdr);
    //bpf_printk("\nIP Type v1: %x", bpf_ntohs(ip_type));
    //bpf_printk("\nIP Type v2: %x", ip_type);
    //bpf_printk("\nIP Type: %x", IPPROTO_TCP);
    if(ip_type != IPPROTO_TCP) {
        //bpf_printk("\nDropped at IP\n\n");
        return 0;
    }

    __be32 saddr = iphdr->saddr; 
    __u8 src_ip;
    src_ip = saddr & 0xFF;
    src_ip = ((saddr >> 8) & 0xFF) ^ src_ip;
    src_ip = ((saddr >> 16) & 0xFF) ^ src_ip;
    src_ip = ((saddr >> 24) & 0xFF) ^ src_ip;
    net_ev->ev_flow_id.src_ip = src_ip;
    //bpf_printk("\nSource IP XOR: %d", src_ip);

    ////bpf_printk("\nsaddr: %d", saddr);
    /*unsigned char src_ip[4];
    src_ip[0] = saddr & 0xFF;
    src_ip[1] = (saddr >> 8) & 0xFF;
    src_ip[2] = (saddr >> 16) & 0xFF;
    src_ip[3] = (saddr >> 24) & 0xFF;*/

    __be32 daddr = iphdr->daddr;
    __u8 dst_ip;
    dst_ip = daddr & 0xFF;
    dst_ip = ((daddr >> 8) & 0xFF) ^ dst_ip;
    dst_ip = ((daddr >> 16) & 0xFF) ^ dst_ip;
    dst_ip = ((daddr >> 24) & 0xFF) ^ dst_ip;
    net_ev->ev_flow_id.dest_ip = dst_ip;

    //bpf_printk("\nDestination IP XOR: %d", dst_ip);
    /*unsigned char dst_ip[4];
    bpf_printk("\ndaddr: %d", daddr);
    dst_ip[0] = daddr & 0xFF;
    dst_ip[1] = (daddr >> 8) & 0xFF;
    dst_ip[2] = (daddr >> 16) & 0xFF;
    dst_ip[3] = (daddr >> 24) & 0xFF;*/
    
    /*bpf_printk("\nSource IP p1: %d.%d", src_ip[0], src_ip[1]);
    bpf_printk("\nSource IP p2: %d.%d", src_ip[2], src_ip[3]);
    bpf_printk("\nDestination IP p1: %d.%d", dst_ip[0], dst_ip[1]);
    bpf_printk("\nDestination IP p2: %d.%d", dst_ip[2], dst_ip[3]);*/
    
    if(parse_tcphdr(&nh, data_end, &tcph) ==  -1) {
        //bpf_printk("\nDropped at TCP\n\n");
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

    net_ev->ack_seq = bpf_ntohl(tcph->ack_seq);
    net_ev->ev_flow_id.src_ip = 0;
    net_ev->ev_flow_id.src_port = 0;
    net_ev->ev_flow_id.dest_ip = 0;
    net_ev->ev_flow_id.dest_port = 0;

    /*bpf_printk("\nDestination port: %d\n\n", num);
    tcph->dest = bpf_htons(bpf_ntohs(tcph->dest) - 1);*/

    //bpf_printk("\nSource port: %d", bpf_ntohs(tcph->source));
    //bpf_printk("\nDestination port: %d\n\n", bpf_ntohs(tcph->dest));

    define_minor_type(net_ev);

    return 1;
}

/*static __always_inline int modify_fake_packet(struct xdp_md *ctx) {
    void *data_end = (void *)(long)ctx->data_end;
    void *data     = (void *)(long)ctx->data;

    void* pos = data;

    struct test *teste = pos;
    if (teste + 1 > data_end)
        return -1;

    pos = teste + 1;
    teste = data;
    teste->value = teste->value + 1;

    return 0;
}*/

static __always_inline void update_app_len(struct app_info *app_info, struct flow_id ev_flow_id) {
    // Note: change this later when we can dynamicaly assign entries to MoM arrays
    struct flow_id key = {0, 0, 0, 0};
    __u32 *app_tail = bpf_map_lookup_elem(&tail_app_hash, &key);
    //__u32 *app_tail = bpf_map_lookup_elem(&tail_app_hash, &ev_flow_id);
    if(!app_tail) {
        __u32 new_tail = 0;
        // Note: change this later when we can dynamicaly assign entries to MoM arrays
        //bpf_map_update_elem(&tail_app_hash, &ev_flow_id, &new_tail, BPF_NOEXIST);
        //app_tail = bpf_map_lookup_elem(&tail_app_hash, &ev_flow_id);
        bpf_map_update_elem(&tail_app_hash, &key, &new_tail, BPF_NOEXIST);
        app_tail = bpf_map_lookup_elem(&tail_app_hash, &key);
        if(!app_tail) {
            bpf_printk("update_app_len: couldn't get entry from app tail map");
            return;
        }
    }
    app_info->app_tail = *app_tail;
    app_info->len_app_queue = (app_info->app_tail - app_info->app_head + MAX_EVENT_QUEUE_LEN) % MAX_EVENT_QUEUE_LEN;
}


static __always_inline struct flow_info * find_flow_info(struct flow_id ev_flow_id) {
    int cpu_id = bpf_get_smp_processor_id();

    struct inner_flow_info_hash *flow_info_hash = bpf_map_lookup_elem(&outer_flow_info_array, &cpu_id);
    if(!flow_info_hash) {
        bpf_printk("find_flow_info: Couldn't get entry from flow info outer map");
        return NULL;
    }
    struct flow_info *f_info = bpf_map_lookup_elem(flow_info_hash, &ev_flow_id);
    if(!f_info) {
        struct flow_info new_f_info = {{0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0}};
        bpf_map_update_elem(flow_info_hash, &ev_flow_id, &new_f_info, BPF_NOEXIST);
        f_info = bpf_map_lookup_elem(flow_info_hash, &ev_flow_id);
        if(!f_info) {
            bpf_printk("find_flow_info: Couldn't get entry from flow info inner map");
            return NULL;
        }
        return f_info;
    }
    return f_info;
}

// static __always_inline int try_to_enqueue(void * map, void * event,
//     struct flow_id flow, int * queue_len, int *tail) {

//     if(*queue_len == MAX_EVENT_QUEUE_LEN - 1) {
//         bpf_printk("Queue is full: unable to enqueue event");
//         return 0;
//     }

//     // Note: change here after I update userspace program to establish entries to hash MoM
//     struct flow_id key = {0, 0, 0, 0};
//     void *inner_array = bpf_map_lookup_elem(map, &key);
//     if(!inner_array) {
//         bpf_printk("try_to_enqueue: Couldn't get entry from outer map");
//         return 0;
//     }

//     if(bpf_map_update_elem(inner_array, tail, event, BPF_ANY)) {
//         bpf_printk("try_to_enqueue: Couldn't update entry from inner map");
//         return 0;
//     }

//     if(*tail < MAX_EVENT_QUEUE_LEN - 1)
//         *tail += 1;
//     else
//         *tail = 0;
    
//     *queue_len += 1;
    
//     return 1;
// }

// static __always_inline void generic_event_enqueue(void * event, enum major_event_type type) {
//     switch (type)
//     {
//     case PROG_EVENT:
//     {
//         bpf_printk("PROG_EVENT");
//         struct prog_event enq_event = *(struct prog_event *) event;
//         struct flow_info *f_info = find_flow_info(enq_event.ev_flow_id);
//         if(!f_info)
//             return;
//         if(!try_to_enqueue(&outer_prog_hash, event, enq_event.ev_flow_id, &(f_info->prog_info.len_prog_queue),
//             &(f_info->prog_info.prog_tail))) {
//             bpf_printk("Unable to enqueue PROG_EVENT");
//         }
//         break;
//     }
    
//     default:
//         return;
//     }
// }

/*static __u64 loop_hash_info(struct bpf_map *map, struct flow_id *key, struct flow_info *val, struct flow_loop_data *data) {
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

// TODO: process only the events with the same flow of the arriving packet
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

static __always_inline int next_event(struct flow_info * f_info) {
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

    // Note: change here also after I update userspace program to establish series to hash MoM
    struct flow_id key = {0, 0, 0, 0};
    
    void * inner_flow_array = bpf_map_lookup_elem(&outer_timer_hash, &key);
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

    // Note: change here also after I update userspace program to establish series to hash MoM
    struct flow_id key = {0, 0, 0, 0};
    
    void * inner_flow_array = bpf_map_lookup_elem(outer_event_hash, &key);
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

static __always_inline int timer_event_enqueue(void *map, struct flow_id *flow, struct timer_trigger *val) {
    struct timer_event event = val->t_event;
    event.valid_bit = 1;

    bpf_printk("TIMER_EVENT");
    struct flow_info *f_info = find_flow_info(event.ev_flow_id);
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

    // Question: do we even need this check? For other event types the events are dropped,
    // so I'm doing the same here
    if(__sync_fetch_and_or(queue_len, 0) == MAX_EVENT_QUEUE_LEN - 1) {
        bpf_printk("try_to_enqueue_timer: queue is full, unable to enqueue event");
        __sync_fetch_and_xor(executing, 1);
        return 0;
    }

    // Note: change here after I update userspace program to establish entries to hash MoM
    //struct inner_net_array *inner_array = bpf_map_lookup_elem(map, &flow);
    struct flow_id key = {0, 0, 0, 0};
    struct inner_timer_array *inner_array = bpf_map_lookup_elem(&outer_timer_hash, &key);
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

static __always_inline int cancel_timer(struct flow_id flow,
    enum timer_instances index) {

    struct flow_id key = {0, 0, 0, 0};
    struct timer_trigger_inner_array * inner_map = bpf_map_lookup_elem(&timer_trigger_outer_hash, &key);
    //struct timer_trigger_inner_array * inner_map = bpf_map_lookup_elem(&timer_trigger_outer_hash, &event->ev_flow_id);
    if(!inner_map) {
        bpf_printk("cancel_timer: Couldn't find outer map entry");
        return -1;
    }
    struct timer_trigger *map_entry = bpf_map_lookup_elem(inner_map, &index);
    if(!map_entry) {
        bpf_printk("cancel_timer: Couldn't find inner map entry");
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

static __always_inline int restart_timer(struct flow_id flow, __u64 time,
    enum timer_instances index) {

    // Note: change here later when the hash MoM have entries initialized at userspace
    struct flow_id key = {0, 0, 0, 0};
    struct timer_trigger_inner_array * inner_map = bpf_map_lookup_elem(&timer_trigger_outer_hash, &key);
    //struct timer_trigger_inner_array * inner_map = bpf_map_lookup_elem(&timer_trigger_outer_hash, &event->ev_flow_id);
    if(!inner_map) {
        bpf_printk("restart_timer: Couldn't find outer map entry");
        return -1;
    }
    struct timer_trigger *map_entry = bpf_map_lookup_elem(inner_map, &index);
    if(!map_entry) {
        bpf_printk("restart_timer: Couldn't find inner map entry");
        return -1;
    }

    if(!map_entry->triggered) {
        bpf_printk("restart_timer: timer isn't currently triggered");
        return -1;
    }

    if(bpf_timer_start(&(map_entry->timer), time, 0) != 0) {
        bpf_printk("restart_timer: couldn't restart timer");
        return -1;
    }

    return 0;
}

static __always_inline int initialize_timer(struct timer_event event,
    __u64 time, enum timer_instances index) {

    // Note: change here later when the hash MoM have entries initialized at userspace
    struct flow_id key = {0, 0, 0, 0};
    struct timer_trigger_inner_array * inner_map = bpf_map_lookup_elem(&timer_trigger_outer_hash, &key);
    //struct timer_trigger_inner_array * inner_map = bpf_map_lookup_elem(&timer_trigger_outer_hash, &event->ev_flow_id);
    if(!inner_map) {
        bpf_printk("initialize_timer: Couldn't find outer map entry");
        return -1;
    }

    /*struct timer_loop_args args;
    bpf_for_each_map_elem(inner_map, find_timer_index_loop, &args, 0);

    // Note: this might be difficult to happen, but what if we don't have any more timers for a flow available?
    if(args.index == NO_TIMER_AVAILABLE) {
        bpf_printk("initialize_timer: There is no timer available for this flow");
        return -1;
    }*/

    struct timer_trigger *map_entry = bpf_map_lookup_elem(inner_map, &index);
    if(!map_entry) {
        bpf_printk("initialize_timer: Couldn't find inner map entry");
        return -1;
    }

    if(map_entry->triggered) {
        bpf_printk("initialize_timer: timer already triggered");
        return -1;
    }

    map_entry->t_event = event;
    map_entry->triggered = 1;

    long int err = bpf_timer_init(&(map_entry->timer), inner_map, CLOCK_BOOTTIME);
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

static __always_inline int send_packet(struct packet_event *pe) {
    bpf_printk("send packet: %u", pe->seq_num);
    return 1;
}

static __always_inline int window_enque(struct packet_event *pe, struct flow_id *fid) {
    struct context *tcp_ctx = bpf_map_lookup_elem(&context_hash, fid);
    if(!tcp_ctx) {
        bpf_printk("tcp_ctx does not exist with the fid");
        return 0;
    }
    // Check if the window is full
    if(tcp_ctx->cur_size == tcp_ctx->window_size) {
        bpf_printk("The window is full, the packet cannot be added");
        return 0;
    }
    // Add the packet
    send_packet(pe);
    __u32 key = (tcp_ctx->head + tcp_ctx->cur_size) % tcp_ctx->window_size;
    bpf_map_update_elem(&window_packets, &key, pe, BPF_ANY);
    tcp_ctx->cur_size += 1;
    bpf_map_update_elem(&context_hash, fid, tcp_ctx, BPF_ANY);
    return 1;
}

static __always_inline int window_deque(struct flow_id *fid) {
    struct context *tcp_ctx = bpf_map_lookup_elem(&context_hash, fid);
    if(!tcp_ctx) {
        bpf_printk("tcp_ctx does not exist with the fid");
        return 0;
    }
    // Check if the window is empty
    if(tcp_ctx->cur_size == 0) {
        bpf_printk("The window is empty, no packet can be removed");
        return 0;
    }
    // Remove the packet
    struct packet_event *pe = bpf_map_lookup_elem(&window_packets, &tcp_ctx->head);
    if(!pe) {
        bpf_printk("The remove packet does not exist");
        return 0;
    }
    tcp_ctx->head = (tcp_ctx->head + 1) % tcp_ctx->window_size;
    tcp_ctx->cur_size -= 1;
    bpf_map_update_elem(&context_hash, fid, tcp_ctx, BPF_ANY);
    return 1;
}

static long app_event_send(__u32 index, struct flow_id *fid) {
    struct context *tcp_ctx = bpf_map_lookup_elem(&context_hash, fid);
    if(!tcp_ctx) {
        bpf_printk("tcp_ctx does not exist with the fid\n");
        return 0;
    }
    struct packet_event pe;
    __builtin_memset(&pe, 0, sizeof(pe));
    pe.fid = fid;
    pe.size =tcp_ctx->segment_size;
    pe.seq_num = tcp_ctx->last_seq_sent + 1;
    window_enque(&pe, fid);
    tcp_ctx->last_seq_sent += 1;
    bpf_map_update_elem(&context_hash, fid, tcp_ctx, BPF_ANY);
    return 0;
}

static __always_inline void app_event_processor(struct app_event *event, struct context *ctx,
    struct intermediate_output *inter_output) {
    struct flow_id fid = event->ev_flow_id;
    // Update size of data to send
    ctx->data_size += event->data_size;
    bpf_printk("data_size: %u", ctx->data_size);
    bpf_map_update_elem(&context_hash, &fid, ctx, BPF_ANY);
    // Update window:
    int data_rest = ctx->data_size - (ctx->last_seq_sent + 1);
    int window_empty_spots = WINDOW_SIZE - ctx->cur_size;
    int num_to_send = data_rest < window_empty_spots ? data_rest : window_empty_spots;
    bpf_loop(num_to_send, app_event_send, &fid, 0);

    // Need this to make ther last update valid: Why?
    struct context *tcp_ctx = bpf_map_lookup_elem(&context_hash, &fid);
    if(!tcp_ctx) {
        bpf_printk("tcp_ctx does not exist with the fid\n");
        return;
    }
    bpf_map_update_elem(&context_hash, &fid, tcp_ctx, BPF_ANY);

    // Create timer event and start timer:
    struct timer_event new_event;
    new_event.ev_flow_id = event->ev_flow_id;
    new_event.event_type = MISS_ACK;
    new_event.seq_num = ctx->window_start_seq;
    initialize_timer(new_event, TEN_SEC, EP_TIMER_TEST);
}

static long update_window(__u32 index, struct flow_id *fid) {
    struct context *tcp_ctx = bpf_map_lookup_elem(&context_hash, fid);
    if(!tcp_ctx) {
        bpf_printk("tcp_ctx does not exist with the fid\n");
        return 0;
    }
    window_deque(fid);
    if(tcp_ctx->data_size == tcp_ctx->last_seq_sent + 1) {
        return 0;
    }
    struct packet_event pe;
    __builtin_memset(&pe, 0, sizeof(pe));
    pe.fid = fid;
    pe.size =tcp_ctx->segment_size;
    pe.seq_num = tcp_ctx->last_seq_sent + 1;
    window_enque(&pe, fid);
    tcp_ctx->last_seq_sent += 1;
    bpf_map_update_elem(&context_hash, fid, tcp_ctx, BPF_ANY);
    return 0;
}

static __always_inline void net_event_processor(struct net_event *event, struct context *ctx,
    struct intermediate_output *inter_output) {
    //Update window
    if(event->ack_seq <= ctx->window_start_seq) return;
    bpf_printk("Received ack: %u", event->ack_seq);
    int data_rest = ctx->data_size - (ctx->last_seq_sent + 1);
    if(data_rest == 0 && event->ack_seq == ctx->last_seq_sent + 1) {
        bpf_printk("All packets sent and received");
        cancel_timer(event->ev_flow_id, EP_TIMER_TEST);
    }
    int num_to_send = event->ack_seq - ctx->window_start_seq;
    ctx->window_start_seq = event->ack_seq;
    bpf_map_update_elem(&context_hash, &event->ev_flow_id, ctx, BPF_ANY);
    struct flow_id fid = event->ev_flow_id;
    bpf_loop(num_to_send, update_window, &fid, 0);
    //Placeholder for reset timer
    restart_timer(event->ev_flow_id, TEN_SEC, EP_TIMER_TEST);
}

static __always_inline void timer_event_processor(struct timer_event *event, struct context *ctx,
    struct intermediate_output *inter_output) {
    // Resend packet
    if(ctx->window_start_seq == event->seq_num) {
        struct packet_event *pe = bpf_map_lookup_elem(&window_packets, &ctx->head);
        if(!pe) {
            bpf_printk("Resent packet not found");
            return;
        }
        send_packet(pe);
    }
}

static __always_inline struct context * retrieve_ctx(struct flow_id flow) {
    struct context *ctx = bpf_map_lookup_elem(&context_hash, &flow);
    if(!ctx) {
        struct context new_ctx = {1, 5, 0, -1, 0, 0, 0};
        bpf_map_update_elem(&context_hash, &flow, &new_ctx, BPF_NOEXIST);
        ctx = bpf_map_lookup_elem(&context_hash, &flow);
        if(!ctx) {
            return NULL;
        }
        return ctx;
    }
    return ctx;
}

static __always_inline void dispatcher(void * event, enum minor_event_type type,
    struct context *ctx) {

    struct intermediate_output inter_output;

    switch (type)
    {
    case SEND:
        bpf_printk("SEND");
        app_event_processor(event, ctx, &inter_output);
        break;
    
    case ACK:
        bpf_printk("ACK");
        net_event_processor(event, ctx, &inter_output);
        break;
    
    case MISS_ACK:
        bpf_printk("MISS_ACK");
        timer_event_processor(event, ctx, &inter_output);
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
    struct flow_info *f_info = arg->f_info;
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
        new_ev.data_size = app_ev->data_size;
        // Set occupied bit to 0
        __sync_fetch_and_xor(&app_ev->occupied, 1);
        dispatcher(&new_ev, minor_type, arg->ctx);
    } else {
        dispatcher(ev, minor_type, arg->ctx);
    }

    return 0;
}

static __always_inline int net_ev_process(struct xdp_md *ctx, struct flow_id * f_id,
    struct context **flow_context) {

    struct net_event net_ev;

    if(!parse_packet(ctx, &net_ev))
        return 0;

    *f_id = net_ev.ev_flow_id;
    *flow_context = retrieve_ctx(*f_id);
    if(!(*flow_context)) {
        bpf_printk("net_ev_process: Couldn't retrive ctx");
        return 0;
    }

    dispatcher(&net_ev, net_ev.event_type, *flow_context);

    return 1;
}

SEC("xdp")
int net_arrive(struct xdp_md *ctx)
{
    //__u64 arrival_time = bpf_ktime_get_ns();
    struct sched_loop_args arg;
    arg.ctx = NULL;

    // Process network event first
    if(!net_ev_process(ctx, &arg.f_id, &arg.ctx))
        return XDP_DROP;
    arg.f_info = find_flow_info(arg.f_id);
    if(!arg.f_info)
        return XDP_DROP;

    update_app_len(&arg.f_info->app_info, arg.f_id);
    //bpf_printk("\n%d %d\n", arg.f_info->timer_info.len_timer_queue, arg.f_info->app_info.len_app_queue);
    //bpf_printk("\n%d\n", arg.f_info->prog_info.len_prog_queue);

    bpf_loop(MAX_NUM_PROCESSED_EVENTS, ev_process_loop, &arg, 0);

    //modify_fake_packet(ctx);

    /* An entry here means that the correspnding queue_id
     * has an active AF_XDP socket bound to it. */
    int rx_queue_index = ctx->rx_queue_index;
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

