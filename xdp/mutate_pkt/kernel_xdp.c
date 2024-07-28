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


/*--------------- XSK MAP ---------------*/

struct {
    __uint(type, BPF_MAP_TYPE_XSKMAP);
    __type(key, __u32);
    __type(value, __u32);
    __uint(max_entries, MAX_NUMBER_CORES);
} xsks_map SEC(".maps");

// Note: make this function more complex in the future
static __always_inline void define_minor_type(struct net_event *net_ev) {
    net_ev->event_type = ACK;
}

static __always_inline int parse_packet(void *data, void *data_end,
    struct net_event *net_ev, struct metadata_hdr *meta_hdr) {

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

    define_minor_type(net_ev);

    __builtin_memcpy(meta_hdr->src_mac, eth->h_source, ETH_ALEN);
    __builtin_memcpy(meta_hdr->dst_mac, eth->h_dest, ETH_ALEN);
    meta_hdr->src_ip = iphdr->saddr;
    meta_hdr->dst_ip = iphdr->daddr;
    meta_hdr->src_port = tcph->source;
    meta_hdr->dst_port = tcph->dest;
    //bpf_printk("Destination port: %d", bpf_ntohs(meta_hdr->dst_port));

    return 1;
}

static __always_inline int mutate_pkt(struct xdp_md *ctx, struct net_event *net_ev,
    __u32 *curr_pkt_len) {

    void *data_end = (void *)(long)ctx->data_end;
    void *data     = (void *)(long)ctx->data;

    __u32 pkt_len = data_end - data;

    __u32 original_header_len = sizeof(struct ethhdr) + sizeof(struct iphdr) + sizeof(struct tcphdr);

    __u32 new_header_len = sizeof(struct metadata_hdr);

    struct metadata_hdr new_hdr;
    new_hdr.data_len = pkt_len - original_header_len;

    if(!parse_packet(data, data_end, net_ev, &new_hdr))
        return 0;

    bpf_xdp_adjust_head(ctx, original_header_len - new_header_len);

    data_end = (void *)(long)ctx->data_end;
    data     = (void *)(long)ctx->data;
    pkt_len = data_end - data;

    *curr_pkt_len = pkt_len;

    if(data + sizeof(new_hdr) > data_end)
        return 0;

    __builtin_memcpy(data, &new_hdr, sizeof(new_hdr));

    bpf_xdp_adjust_tail(ctx, 2000);

    return 1;
}

static __always_inline void update_pkt_len(struct xdp_md *redirect_pkt, __u32 curr_pkt_len) {
    void *data_end = (void *)(long)redirect_pkt->data_end;
    void *data     = (void *)(long)redirect_pkt->data;
    struct metadata_hdr meta_cpy;

    if(data + sizeof(meta_cpy) > data_end)
        return;

    __builtin_memcpy(&meta_cpy, data, sizeof(meta_cpy));
    meta_cpy.metadata_end = curr_pkt_len;
    bpf_printk("%d", meta_cpy.metadata_end);

    if(data + sizeof(meta_cpy) > data_end)
        return;
    
    __builtin_memcpy(data, &meta_cpy, sizeof(meta_cpy));
}

static __always_inline void example_ep(struct xdp_md *redirect_pkt, __u32 *curr_pkt_len, 
    int type) {

    if(type) {
        bpf_printk("NET %d", *curr_pkt_len);

        struct net_metadata metadata = {0, 1, 2};

        if(*curr_pkt_len > 4000)
            return;

        if((void *)(long)redirect_pkt->data + (*curr_pkt_len) + sizeof(metadata) > (void *)(long)redirect_pkt->data_end)
            return;

        __builtin_memcpy((void *)(long)redirect_pkt->data + (*curr_pkt_len), &metadata, sizeof(metadata));

        *curr_pkt_len += sizeof(metadata);

    } else {
        bpf_printk("APP %d", *curr_pkt_len);
        struct app_metadata metadata = {1, 6, 7, 8, 9};

        if(*curr_pkt_len > 4000)
            return;

        if((void *)(long)redirect_pkt->data + (*curr_pkt_len) + sizeof(metadata) > (void *)(long)redirect_pkt->data_end)
            return;

        __builtin_memcpy((void *)(long)redirect_pkt->data + (*curr_pkt_len), &metadata, sizeof(metadata));

        *curr_pkt_len += sizeof(metadata);
    }

}

static long ev_process_loop(__u32 index, struct sched_loop_args * arg) {
    example_ep(arg->redirect_pkt, &arg->curr_pkt_len, 0);

    return 0;
}

static __always_inline int net_ev_process(struct xdp_md *redirect_pkt, struct flow_id * f_id,
    __u32 *curr_pkt_len) {

    struct net_event net_ev;

    if(!mutate_pkt(redirect_pkt, &net_ev, curr_pkt_len))
        return 0;

    *f_id = net_ev.ev_flow_id;

    example_ep(redirect_pkt, curr_pkt_len, 1);

    return 1;
}

SEC("xdp")
int net_arrive(struct xdp_md *ctx)
{
    //__u64 arrival_time = bpf_ktime_get_ns();

    struct sched_loop_args arg;
    arg.redirect_pkt = ctx;
    // Process network event first
    if(!net_ev_process(ctx, &arg.f_id, &arg.curr_pkt_len))
        return XDP_DROP;

    bpf_loop(MAX_NUM_PROCESSED_EVENTS, ev_process_loop, &arg, 0);

    bpf_printk("%d", arg.curr_pkt_len);

    update_pkt_len(ctx, arg.curr_pkt_len);

    /* An entry here means that the correspnding queue_id
     * has an active AF_XDP socket bound to it. */
    int rx_queue_index = ctx->rx_queue_index;
    if (bpf_map_lookup_elem(&xsks_map, &rx_queue_index)) {
        return bpf_redirect_map(&xsks_map, rx_queue_index, 0);
    }

    return XDP_DROP;
}

char _license[] SEC("license") = "GPL";

