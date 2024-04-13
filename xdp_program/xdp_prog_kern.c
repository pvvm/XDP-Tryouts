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

struct inner_map_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, __u64);
    __uint(max_entries, MAX_NUMBER_CORES);
} inner_map_array0 SEC(".maps"), inner_map_array1 SEC(".maps"), inner_map_array2 SEC(".maps"), inner_map_array3 SEC(".maps"),
inner_map_array4 SEC(".maps"), inner_map_array5 SEC(".maps"), inner_map_array6 SEC(".maps"), inner_map_array7 SEC(".maps");

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
    __uint(max_entries, MAX_NUMBER_CORES);
    __type(key, __u32);
    __array(values, struct inner_map_array);
} outer_map_array SEC(".maps") = {
    .values = {&inner_map_array0, &inner_map_array1, &inner_map_array2, &inner_map_array3,
    &inner_map_array4, &inner_map_array5, &inner_map_array6, &inner_map_array7}
};

struct inner_map_queue {
    __uint(type, BPF_MAP_TYPE_QUEUE);
    __type(value, __u64);
    __uint(max_entries, 32);
} inner_map_queue0 SEC(".maps"), inner_map_queue1 SEC(".maps"), inner_map_queue2 SEC(".maps"), inner_map_queue3 SEC(".maps"),
inner_map_queue4 SEC(".maps"), inner_map_queue5 SEC(".maps"), inner_map_queue6 SEC(".maps"), inner_map_queue7 SEC(".maps")/*,
inner_map_aux SEC(".maps")*/;

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
    __uint(max_entries, MAX_NUMBER_CORES /*8*/);
    __type(key, __u32);
    __array(values, struct inner_map_queue);
} outer_map_queue SEC(".maps") = {
    .values = {&inner_map_queue0, &inner_map_queue1, &inner_map_queue2, &inner_map_queue3,
    &inner_map_queue4, &inner_map_queue5, &inner_map_queue6, &inner_map_queue7/*, &inner_map_aux*/}
};

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, __u64);
    __uint(max_entries, MAX_NUMBER_CORES);
} common_array SEC(".maps");

struct {
    __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
    __type(key, __u32);
    __type(value, __u64);
    __uint(max_entries, MAX_NUMBER_CORES);
} percpu_array SEC(".maps");

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, __u64);
    __uint(max_entries, MAX_NUMBER_CORES);
} counter_array SEC(".maps");

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, __u64);
    __uint(max_entries, MAX_NUMBER_CORES);
} time_array SEC(".maps");

/*static __always_inline int parse_packet(struct xdp_md *ctx) {
    void *data_end = (void *)(long)ctx->data_end;
    void *data     = (void *)(long)ctx->data;

    bpf_printk("\nRX queue index: %u", ctx->rx_queue_index);

    struct ethhdr *eth;
    struct iphdr *iphdr;
    struct tcphdr *tcph;

    struct hdr_cursor nh;
    int eth_type, ip_type;

    nh.pos = data;

    eth_type = parse_ethhdr(&nh, data_end, &eth);
    if (eth_type != bpf_htons(ETH_P_IP)) {
        bpf_printk("\nDropped at eth. Type: %x\n\n", bpf_ntohs(eth_type));
        return 0;
    }


    bpf_printk("\nSource MAC p1: %x:%x:%x",
               eth->h_source[0], eth->h_source[1], eth->h_source[2]);
    bpf_printk("\nSource MAC p2: %x:%x:%x",
               eth->h_source[3], eth->h_source[4], eth->h_source[5]);

    bpf_printk("\nDest MAC p1: %x:%x:%x",
               eth->h_dest[0], eth->h_dest[1], eth->h_dest[2]);
    bpf_printk("\nDest MAC p2: %x:%x:%x",
               eth->h_dest[3], eth->h_dest[4], eth->h_dest[5]);
    bpf_printk("\nEtherType: %x", bpf_ntohs(eth->h_proto));

    ip_type = parse_iphdr(&nh, data_end, &iphdr);
    bpf_printk("\nIP Type v1: %x", bpf_ntohs(ip_type));
    bpf_printk("\nIP Type v2: %x", ip_type);
    bpf_printk("\nIP Type: %x", IPPROTO_TCP);
    if(ip_type != IPPROTO_TCP) {
        bpf_printk("\nDropped at IP\n\n");
        return 0;
    }

    unsigned char src_ip[4];
    //unsigned char dst_ip[4];
    __be32 saddr = iphdr->saddr; 
    //bpf_printk("\nsaddr: %d", saddr);
    src_ip[0] = saddr & 0xFF;
    src_ip[1] = (saddr >> 8) & 0xFF;
    src_ip[2] = (saddr >> 16) & 0xFF;
    src_ip[3] = (saddr >> 24) & 0xFF;

    unsigned char dst_ip[4];
    //unsigned char dst_ip[4];
    __be32 daddr = iphdr->daddr;
    //bpf_printk("\ndaddr: %d", daddr);
    dst_ip[0] = daddr & 0xFF;
    dst_ip[1] = (daddr >> 8) & 0xFF;
    dst_ip[2] = (daddr >> 16) & 0xFF;
    dst_ip[3] = (daddr >> 24) & 0xFF;
    
    bpf_printk("\nSource IP p1: %d.%d", src_ip[0], src_ip[1]);
    bpf_printk("\nSource IP p2: %d.%d", src_ip[2], src_ip[3]);
    bpf_printk("\nDestination IP p1: %d.%d", dst_ip[0], dst_ip[1]);
    bpf_printk("\nDestination IP p2: %d.%d", dst_ip[2], dst_ip[3]);
    
    if(parse_tcphdr(&nh, data_end, &tcph) ==  -1) {
        bpf_printk("\nDropped at TCP\n\n");
        return 0;
    }

    bpf_printk("\nSource port: %d", bpf_ntohs(tcph->source));
    bpf_printk("\nDestination port: %d\n\n", bpf_ntohs(tcph->dest));

    return 1;
}*/

static __always_inline __u64 update_counter (int key_cpu) {
    __u64 * value = bpf_map_lookup_elem(&counter_array, &key_cpu);
    if(!value)
        return 0;

    __u64 new_value = (* value) + 1;
    bpf_map_update_elem(&counter_array, &key_cpu, &new_value, BPF_ANY);

    return new_value;
}

static __always_inline int update_time (__u64 arrival_time, __u64 finish_time, int key_cpu) {
    __u64 * value = bpf_map_lookup_elem(&time_array, &key_cpu);
    if(!value)
        return 0;

    __u64 new_value = (* value) + (finish_time - arrival_time);
    bpf_map_update_elem(&time_array, &key_cpu, &new_value, BPF_ANY);

    return 1;
}

static __always_inline int lookup_map (int key, void * map_pointer) {
    __u64 * value = bpf_map_lookup_elem(map_pointer, &key);

    if(!value)
        return 0;

    //bpf_printk("\nCurrent key: %d\nValue: %d", key, *value);

    //*value += 1;

    __u64 new_value = (* value) + 1;
    bpf_map_update_elem(map_pointer, &key, &new_value, BPF_ANY);

    return 1;
}

SEC("xdp")
int  common_array_lookup_diff_keys(struct xdp_md *ctx)
{
    int cpu = bpf_get_smp_processor_id();

    // Update counter map
    if(!update_counter(cpu)) {
        bpf_printk("Error while looking up counter map");
    }

    __u64 arrival_time = bpf_ktime_get_ns();

    // Lookup common map
    for(int i = 0; i < 100; i++)
        lookup_map(cpu, &common_array);

    __u64 finish_time = bpf_ktime_get_ns();
    if(!update_time(arrival_time, finish_time, cpu)) {
        bpf_printk("Error while looking up timer map");
    }

    return XDP_DROP;
}


// TODO: check if with a HASH map I can have different queues
// or if they are all the same for all CPUs
SEC("xdp")
int  percpu_array_lookup(struct xdp_md *ctx)
{
    int cpu = bpf_get_smp_processor_id();

    // Update counter map
    if(!update_counter(cpu)) {
        bpf_printk("Error while looking up counter map");
    }

    __u64 arrival_time = bpf_ktime_get_ns();

    // Lookup percpu map
    for(int i = 0; i < 100; i++)
        lookup_map(0, &percpu_array);

    __u64 finish_time = bpf_ktime_get_ns();
    if(!update_time(arrival_time, finish_time, cpu)) {
        bpf_printk("Error while looking up timer map");
    }

    return XDP_DROP;
}

SEC("xdp")
int  common_array_lookup_same_keys(struct xdp_md *ctx)
{
    int cpu = bpf_get_smp_processor_id();

    // Update counter map
    if(!update_counter(cpu)) {
        bpf_printk("Error while looking up counter map\n");
    }

    __u64 arrival_time = bpf_ktime_get_ns();

    // Lookup common map
    for(int i = 0; i < 100; i++)
        lookup_map(0, &common_array);

    __u64 finish_time = bpf_ktime_get_ns();
    if(!update_time(arrival_time, finish_time, cpu)) {
        bpf_printk("Error while looking up timer map\n");
    }

    return XDP_DROP;
}


SEC("xdp")
int  simply_drop(struct xdp_md *ctx)
{

    int cpu = bpf_get_smp_processor_id();

    /*void *data_end = (void *)(long)ctx->data_end;
    void *data = (void *)(long)ctx->data;
    bpf_printk("\nLength of packet: %d", data_end - data);*/

    // Update counter map
    if(!update_counter(cpu)) {
        bpf_printk("Error while looking up counter map\n");
    }

    //parse_packet(ctx);

    __u64 arrival_time = bpf_ktime_get_ns();

    __u64 finish_time = bpf_ktime_get_ns();
    if(!update_time(arrival_time, finish_time, cpu)) {
        bpf_printk("Error while looking up timer map\n");
    }

    return XDP_DROP;
}

static __always_inline __u64 lookup_map_of_maps_queue (int key, __u64 counter/*, int iteration*/) {
    //if(iteration == 0) {
        struct inner_map_queue *map = bpf_map_lookup_elem(&outer_map_queue, &key);

        if(!map) {
            bpf_printk("Error while accessing map of maps\n");
            return 0;
        }

        __u64 check_value = -1;
        if(counter > 32) {
            bpf_map_pop_elem(map, &check_value);

            if(check_value != counter - 32) {
                counter = 0;
                //bpf_printk("The queue missed counter %d", check_value + 32);
            }
        }
        
        if(bpf_map_push_elem(map, &counter, BPF_EXIST) < 0) {
            bpf_printk("Error while accessing pushing element to queue\n");
            return 0;
        }
    /*} else {
        key = 8;
        __u64 value = 0;
        struct inner_map *map = bpf_map_lookup_elem(&outer_map, &key);
        if(!map) {
            bpf_printk("Error while accessing map of maps\n");
            return 0;
        }

        bpf_map_pop_elem(map, &value);
        if(bpf_map_push_elem(map, &value, BPF_EXIST) < 0) {
            bpf_printk("Error while accessing pushing element to queue\n");
            return 0;
        }
    }*/

    return counter;
}

SEC("xdp")
int  map_of_maps_queue(struct xdp_md *ctx)
{
    int cpu = bpf_get_smp_processor_id();

    // Update counter map
    __u64 counter = update_counter(cpu);
    if(counter == 0) {
        bpf_printk("Error while looking up counter map\n");
    }

    __u64 arrival_time = bpf_ktime_get_ns();

    for(int i = 0; i < 100; i++)
        lookup_map_of_maps_queue(cpu, counter/*, i*/);

    __u64 finish_time = bpf_ktime_get_ns();
    if(!update_time(arrival_time, finish_time, cpu)) {
        bpf_printk("Error while looking up timer map\n");
    }

    return XDP_DROP;
}

static __always_inline int lookup_map_of_maps_array (int key) {

    struct inner_map_array *map = bpf_map_lookup_elem(&outer_map_array, &key);

    if(!map) {
        bpf_printk("Error while accessing map of maps\n");
        return 0;
    }

    int inner_map_key = 0;
    __u64 * value = bpf_map_lookup_elem(map, &inner_map_key);

    if(!value)
        return 0;

    __u64 new_value = (* value) + 1;
    bpf_map_update_elem(map, &inner_map_key, &new_value, BPF_ANY);

    return 1;
}

SEC("xdp")
int map_of_maps_array(struct xdp_md *ctx)
{
    int cpu = bpf_get_smp_processor_id();

    if(!update_counter(cpu)) {
        bpf_printk("Error while looking up counter map\n");
    }

    __u64 arrival_time = bpf_ktime_get_ns();

    for(int i = 0; i < 100; i++)
        lookup_map_of_maps_array(cpu);

    __u64 finish_time = bpf_ktime_get_ns();
    if(!update_time(arrival_time, finish_time, cpu)) {
        bpf_printk("Error while looking up timer map\n");
    }

    return XDP_DROP;
}

SEC("xdp")
int gets_cpu_id (struct xdp_md *ctx)
{
    int cpu;

    __u64 arrival_time = bpf_ktime_get_ns();
    for(int i = 0; i < 100; i++)
        cpu = bpf_get_smp_processor_id();

    __u64 finish_time = bpf_ktime_get_ns();

    if(!update_counter(cpu)) {
        bpf_printk("Error while looking up counter map\n");
    }

    if(!update_time(arrival_time, finish_time, cpu)) {
        bpf_printk("Error while looking up timer map\n");
    }

    return XDP_DROP;
}

char _license[] SEC("license") = "GPL";
