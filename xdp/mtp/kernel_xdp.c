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

struct {
	__uint(type, BPF_MAP_TYPE_XSKMAP);
	__type(key, __u32);
	__type(value, __u32);
	__uint(max_entries, MAX_NUMBER_CORES);
} xsks_map SEC(".maps");

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
    __type(key, struct hash_key);
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


static __always_inline int parse_packet(struct xdp_md *ctx) {
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

    unsigned char src_ip[4];
    //unsigned char dst_ip[4];
    __be32 saddr = iphdr->saddr; 
    ////bpf_printk("\nsaddr: %d", saddr);
    src_ip[0] = saddr & 0xFF;
    src_ip[1] = (saddr >> 8) & 0xFF;
    src_ip[2] = (saddr >> 16) & 0xFF;
    src_ip[3] = (saddr >> 24) & 0xFF;

    unsigned char dst_ip[4];
    //unsigned char dst_ip[4];
    __be32 daddr = iphdr->daddr;
    ////bpf_printk("\ndaddr: %d", daddr);
    dst_ip[0] = daddr & 0xFF;
    dst_ip[1] = (daddr >> 8) & 0xFF;
    dst_ip[2] = (daddr >> 16) & 0xFF;
    dst_ip[3] = (daddr >> 24) & 0xFF;
    
    //bpf_printk("\nSource IP p1: %d.%d", src_ip[0], src_ip[1]);
    //bpf_printk("\nSource IP p2: %d.%d", src_ip[2], src_ip[3]);
    //bpf_printk("\nDestination IP p1: %d.%d", dst_ip[0], dst_ip[1]);
    //bpf_printk("\nDestination IP p2: %d.%d", dst_ip[2], dst_ip[3]);
    
    if(parse_tcphdr(&nh, data_end, &tcph) ==  -1) {
        //bpf_printk("\nDropped at TCP\n\n");
        return 0;
    }

    bpf_printk("\nDestination port: %d\n\n", bpf_ntohs(tcph->dest));
    tcph->dest = bpf_htons(bpf_ntohs(tcph->dest) - 1);

    //bpf_printk("\nSource port: %d", bpf_ntohs(tcph->source));
    bpf_printk("\nDestination port: %d\n\n", bpf_ntohs(tcph->dest));

    return 1;
}

SEC("xdp")
int xdp_sock_prog(struct xdp_md *ctx)
{
    int index = ctx->rx_queue_index;

    if(!parse_packet(ctx))
        return XDP_DROP;

    /* A set entry here means that the correspnding queue_id
     * has an active AF_XDP socket bound to it. */
    int cpu = bpf_get_smp_processor_id();

    if (bpf_map_lookup_elem(&xsks_map, &index)) {
        bpf_printk("TEST %d %d", cpu, index);
        return bpf_redirect_map(&xsks_map, index, 0);
	}

    return XDP_PASS;
}

char _license[] SEC("license") = "GPL";
