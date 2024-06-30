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

/*--------------- SHARED HEAD TAIL MAP ---------------*/

struct {
    __uint(type, BPF_MAP_TYPE_HASH);
    __type(key, struct flow_id);
    __type(value, struct queue_head_tail);
    __uint(max_entries, MAX_EVENT_QUEUE_LEN);
} head_tail_hash SEC(".maps");


/*--------------- NET EVENT MAPS ---------------*/

struct inner_net_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct net_event);
    __uint(max_entries, MAX_EVENT_QUEUE_LEN);
} inner_net_array0 SEC(".maps"), inner_net_array1 SEC(".maps"), inner_net_array2 SEC(".maps"), inner_net_array3 SEC(".maps"),
inner_net_array4 SEC(".maps"), inner_net_array5 SEC(".maps"), inner_net_array6 SEC(".maps"), inner_net_array7 SEC(".maps"),
inner_net_array8 SEC(".maps"), inner_net_array9 SEC(".maps"), inner_net_array10 SEC(".maps"), inner_net_array11 SEC(".maps"),
inner_net_array12 SEC(".maps"), inner_net_array13 SEC(".maps"), inner_net_array14 SEC(".maps"), inner_net_array15 SEC(".maps"),
inner_net_array16 SEC(".maps"), inner_net_array17 SEC(".maps"), inner_net_array18 SEC(".maps"), inner_net_array19 SEC(".maps");

struct outer_net_hash {
    __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
    __type(key, struct flow_id);
    __uint(max_entries, MAX_NUMBER_FLOWS);
    __array(values, struct inner_net_array);
} outer_net_hash SEC(".maps") = {
    .values = {
        [0] = &inner_net_array0, [1] = &inner_net_array1, [2] = &inner_net_array2, [3] = &inner_net_array3, [4] = &inner_net_array4,
        [5] = &inner_net_array5, [6] = &inner_net_array6, [7] = &inner_net_array7, [8] = &inner_net_array8, [9] = &inner_net_array9,
        [10] = &inner_net_array10, [11] = &inner_net_array11, [12] = &inner_net_array12, [13] = &inner_net_array13, [14] = &inner_net_array14,
        [15] = &inner_net_array15, [16] = &inner_net_array16, [17] = &inner_net_array17, [18] = &inner_net_array18, [19] = &inner_net_array19,
    },
};

/*--------------- TIMER EVENT MAPS ---------------*/

struct inner_timer_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct net_event);
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

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct timer_trigger);
    __uint(max_entries, MAX_NUMBER_CORES);
} timer_array SEC(".maps");

static __always_inline int parse_packet(struct xdp_md *ctx, struct net_event *net_ev) {
    void *data_end = (void *)(long)ctx->data_end;
    void *data     = (void *)(long)ctx->data;

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
    
    /*bpf_printk("\nDestination port: %d\n\n", num);
    tcph->dest = bpf_htons(bpf_ntohs(tcph->dest) - 1);*/

    //bpf_printk("\nSource port: %d", bpf_ntohs(tcph->source));
    //bpf_printk("\nDestination port: %d\n\n", bpf_ntohs(tcph->dest));

    return 1;
}

/*static int timer_triggered(void *map, __u32 *key, struct timer_trigger *val) {
    bpf_printk("CPU: %d", *key);
    return 0;
}

static __always_inline int initialize_timer(int cpu) {
    struct timer_trigger *map_entry;

    map_entry = bpf_map_lookup_elem(&timer_array, &cpu);
    if(!map_entry) {
        bpf_printk("Couldn't get entry of the map");
        return -1;
    }

    long int i = bpf_timer_init(&map_entry->timer, &timer_array, CLOCK_BOOTTIME);
    if(i != 0) {
        bpf_printk("Error while initializing timer: %ld", i);
    }

    // Sets the function to be called after the timer triggers
    i = bpf_timer_set_callback(&map_entry->timer, timer_triggered);
    if(i != 0) {
        bpf_printk("Error while setting callback: %ld", i);
    }

    // Starts the timer for 1 second
    bpf_timer_start(&map_entry->timer, ONE_SEC, 0);

    return 0;
}*/

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


// Note: change this function so it simply initializes and returns the flow_info (contains head and tail, and length)
static __always_inline int find_head_tail(struct flow_id ev_flow_id, struct queue_head_tail **ht_info) {
    *ht_info = bpf_map_lookup_elem(&head_tail_hash, &ev_flow_id);
    if(!(*ht_info)) {
        struct queue_head_tail new_ht_info = {0, 0, 0, 0, 0, 0};
        bpf_map_update_elem(&head_tail_hash, &ev_flow_id, &new_ht_info, BPF_NOEXIST);
        //bpf_printk("Creating new entry in hash map");
        *ht_info = bpf_map_lookup_elem(&head_tail_hash, &ev_flow_id);
        if(!*(ht_info))
            return 0;
    }
    //bpf_printk("Found entry in hash map");
    return 1;
}

// Note: maybe we won't even need this function. We can do this in try_to_enqueue and dequeue
/*static __always_inline int update_flow_info(struct flow_id ev_flow_id, int cpu_id,
    int inc_or_dec, enum event_type type) {

    struct inner_flow_info_hash *flow_info_hash = bpf_map_lookup_elem(&outer_flow_info_array, &cpu_id);
    if(!flow_info_hash) {
        bpf_printk("Couldn't get entry from flow info outer map");
        return 0;
    }
    struct flow_info *f_info = bpf_map_lookup_elem(flow_info_hash, &ev_flow_id);
    if(!f_info) {
        struct flow_info new_f_info = {0, 0, 0, 0};
        bpf_map_update_elem(flow_info_hash, &ev_flow_id, &new_f_info, BPF_NOEXIST);
        f_info = bpf_map_lookup_elem(flow_info_hash, &ev_flow_id);
        if(!f_info) {
            bpf_printk("Couldn't get entry from flow info inner map");
            return 0;
        }
    }

    switch (type) {
    case APP_EVENT:
        f_info->len_app_queue += inc_or_dec;
        break;
    case NET_EVENT:
        f_info->len_net_queue += inc_or_dec;
        break;
    case TIMER_EVENT:
        f_info->len_timer_queue += inc_or_dec;
        break;
    case PROG_EVENT:
        f_info->len_prog_queue += inc_or_dec;
        break;
    default:
        break;
    }

    return 1;
}*/

static __always_inline int try_to_enqueue(void * map, void * event, struct flow_id flow, int * head, int *tail) {
    if((*head == 0 && *tail == MAX_EVENT_QUEUE_LEN - 1) ||
        *head == *tail + 1) {
        bpf_printk("Queue is full: unable to enqueue event");
        return 0;
    }

    //struct flow_id test = flow;

    // Note: change here after I update userspace program to establish entries to hash MoM
    struct flow_id key = {0, 0, 0, 0};
    struct inner_net_array *inner_array = bpf_map_lookup_elem(map, &key);
    if(!inner_array) {
        bpf_printk("Couldn't get entry from outer map");
        return 0;
    }

    if(bpf_map_update_elem(inner_array, tail, event, BPF_ANY)) {
        bpf_printk("Couldn't update entry from inner map");
        return 0;
    }

    /*struct net_event * enq_event = (struct net_event *) bpf_map_lookup_elem(inner_array, tail);
    if(!enq_event)
        return 0;
    bpf_printk("%d %d", enq_event->ev_flow_id.src_ip, enq_event->ev_flow_id.dest_ip);*/

    if(*tail < MAX_EVENT_QUEUE_LEN - 1)
        *tail += 1;
    else
        *tail= 0;
    
    return 1;
}

static __always_inline void event_enqueue(void * event, enum event_type type) {
    if(type == APP_EVENT) {
        bpf_printk("APP_EVENT");
       //struct app_event enq_event = *(struct app_event *) event;
    } else if(type == NET_EVENT) {
        bpf_printk("NET_EVENT");
        struct net_event enq_event = *(struct net_event *) event;
        struct queue_head_tail *ht_info;
        find_head_tail(enq_event.ev_flow_id, &ht_info);
        if(!ht_info)
            return;
        //bpf_printk("TAIL: %d", ht_info->net_tail);
        if(!try_to_enqueue(&outer_net_hash, event, enq_event.ev_flow_id, &(ht_info->net_head), &(ht_info->net_tail))) {
            bpf_printk("Unable to enqueue event");
        }

    } else if(type == TIMER_EVENT) {
        bpf_printk("TIMER_EVENT");
        struct timer_event enq_event = *(struct timer_event *) event;
        struct queue_head_tail *ht_info;
        find_head_tail(enq_event.ev_flow_id, &ht_info);
        if(!ht_info)
            return;
        if(!try_to_enqueue(&outer_timer_hash, event, enq_event.ev_flow_id, &(ht_info->timer_head), &(ht_info->timer_tail))) {
            bpf_printk("Unable to enqueue event");
        }

    } else if(type == PROG_EVENT) {
        bpf_printk("PROG_EVENT");
        //struct prog_event enq_event = *(struct prog_event *) event;
    }
}

/*static __always_inline struct flow_id next_flow() {


    //return flow_id;
}*/

static __always_inline void scheduler(void * event, enum event_type type, struct xdp_md *ctx) {
    event_enqueue(event, type);

    //struct net_event teste = *(struct net_event *) event;
    //bpf_printk("%d %d", teste.ev_flow_id.src_ip, teste.ev_flow_id.dest_ip);
    //bpf_printk("%d %d", teste.ev_flow_id.src_port, teste.ev_flow_id.dest_port);

    //struct flow_id flow = next_flow();
}

SEC("xdp")
int rx_module(struct xdp_md *ctx)
{
    int rx_queue_index = ctx->rx_queue_index;
    struct net_event net_ev;

    if(!parse_packet(ctx, &net_ev))
        return XDP_DROP;

    scheduler((void *) &net_ev, NET_EVENT, ctx);

    //modify_fake_packet(ctx);
    
    //int cpu = bpf_get_smp_processor_id();

    //initialize_timer(cpu);

    /* An entry here means that the correspnding queue_id
     * has an active AF_XDP socket bound to it. */
    if (bpf_map_lookup_elem(&xsks_map, &rx_queue_index)) {
        //bpf_printk("TEST %d %d", cpu, rx_queue_index);
        return bpf_redirect_map(&xsks_map, rx_queue_index, 0);
	}
    return XDP_DROP;
}

char _license[] SEC("license") = "GPL";
