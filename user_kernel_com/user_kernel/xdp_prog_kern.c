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

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, __u64);
    __uint(max_entries, MAX_NUMBER_CORES);
} counter_array SEC(".maps");

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


SEC("xdp")
int  simply_drop(struct xdp_md *ctx)
{

    int cpu = bpf_get_smp_processor_id();
    //bpf_printk("\nCPU: %d", cpu);

    /*void *data_end = (void *)(long)ctx->data_end;
    void *data = (void *)(long)ctx->data;
    bpf_printk("\nLength of packet: %d", data_end - data);*/

    // Update counter map
    if(!update_counter(cpu)) {
        bpf_printk("Error while looking up counter map\n");
    }

    //parse_packet(ctx);

    /*int key = 0;
    __u64 * value = bpf_map_lookup_elem(&inner_map_array0, &key);

    if(!value)
        return 0;

    __u64 new_value = (* value) + 1;
    bpf_map_update_elem(&inner_map_array0, &key, &new_value, BPF_ANY);

    struct inner_map_array *map = bpf_map_lookup_elem(&outer_map_array, &key);
    if(!map) {
        bpf_printk("Error while accessing map of maps\n");
        return 0;
    }

    __u64 * value_inner = bpf_map_lookup_elem(map, &key);

    if(!value_inner)
        return 0;

    bpf_printk("%llu", *value_inner);*/

    return XDP_DROP;
}

char _license[] SEC("license") = "GPL";
