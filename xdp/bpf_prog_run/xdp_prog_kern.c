/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
#include <linux/in.h>
#include <bpf/bpf_helpers.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>

#include "../common/parsing_helpers.h"

#define MAX_NUMBER_CORES 8

__u64 real_fake_packet[MAX_NUMBER_CORES];

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, __u64);
    __uint(max_entries, MAX_NUMBER_CORES);
} counter_array SEC(".maps");

struct inner_map_queue {
    __uint(type, BPF_MAP_TYPE_QUEUE);
    __type(value, __u32);
    __uint(max_entries, 9824);
} inner_map_queue0 SEC(".maps"), inner_map_queue1 SEC(".maps"), inner_map_queue2 SEC(".maps"), inner_map_queue3 SEC(".maps"),
inner_map_queue4 SEC(".maps"), inner_map_queue5 SEC(".maps"), inner_map_queue6 SEC(".maps"), inner_map_queue7 SEC(".maps");

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
    __uint(max_entries, MAX_NUMBER_CORES);
    __type(key, __u32);
    __array(values, struct inner_map_queue);
} outer_map_queue SEC(".maps") = {
    .values = {&inner_map_queue0, &inner_map_queue1, &inner_map_queue2, &inner_map_queue3,
    &inner_map_queue4, &inner_map_queue5, &inner_map_queue6, &inner_map_queue7}
};

static __always_inline __u64 update_counter (int key_cpu) {
    __u64 * value = bpf_map_lookup_elem(&counter_array, &key_cpu);
    if(!value)
        return 0;

    //__u64 new_value = (* value) + 1;
    //bpf_map_update_elem(&counter_array, &key_cpu, &new_value, BPF_ANY);
    *value += 1;

    return *value;
}

static __always_inline int lookup_map_of_maps_queue (int key, int number) {
    struct inner_map_queue *map = bpf_map_lookup_elem(&outer_map_queue, &key);

    if(!map) {
        bpf_printk("Error while accessing map of maps\n");
        return 0;
    }

    while(number < 10) {
        int i = number;
        if(bpf_map_push_elem(map, &i, BPF_EXIST) < 0) {
            bpf_printk("Error while pushing element to queue\n");
            return 0;
        }
        number += 2;
    }

    return 1;
}


SEC("xdp")
int  simply_drop(struct xdp_md *ctx)
{
    int cpu = bpf_get_smp_processor_id();
    //if(0 <= cpu && cpu < MAX_NUMBER_CORES)
    //    __sync_fetch_and_or(&real_fake_packet[cpu], 1);

    void *data_end = (void *)(long)ctx->data_end;
    void *data     = (void *)(long)ctx->data;

    /*struct ethhdr *eth;
    struct iphdr *iphdr;

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

    cpu = bpf_get_smp_processor_id();
    
    if(iphdr->id == 65535) {
        if(0 <= cpu && cpu < MAX_NUMBER_CORES) {
        __sync_fetch_and_and(&real_fake_packet[cpu], 0);
    }
    }*/

    // Update counter map
    __u64 counter = update_counter(cpu);
    if(counter == 0) {
        bpf_printk("Error while looking up counter map\n");
    }

    if(counter < 10000000) {
        if(data_end - data == 1500) {
            lookup_map_of_maps_queue(cpu, 0);
        } else {
            lookup_map_of_maps_queue(cpu, 1);
        }
    }

    /*cpu = bpf_get_smp_processor_id();
    if(iphdr->id == 65535) {
        if(0 <= cpu && cpu < MAX_NUMBER_CORES) {
            //bpf_printk("%d", real_fake_packet[cpu]);
            if(__sync_fetch_and_or(&real_fake_packet[cpu], 0))
                bpf_printk("IT HAPPENED");
        }
    }*/

    return XDP_DROP;
}

char _license[] SEC("license") = "GPL";
