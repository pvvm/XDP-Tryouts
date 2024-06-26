/* SPDX-License-Identifier: GPL-2.0 */

#include <linux/bpf.h>

#include <linux/in.h>

#include <linux/if_ether.h>

#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
#include "../common/parsing_helpers.h"
#include "../common/rewrite_helpers.h"


struct {
	__uint(type, BPF_MAP_TYPE_XSKMAP);
	__type(key, __u32);
	__type(value, __u32);
	__uint(max_entries, 64);
} xsks_map SEC(".maps");

struct {
	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
	__type(key, __u32);
	__type(value, __u32);
	__uint(max_entries, 64);
} xdp_stats_map SEC(".maps");

SEC("xdp_sock")
int xdp_sock_prog(struct xdp_md *ctx)
{
    int index = ctx->rx_queue_index;
    __u32 *pkt_count;

    pkt_count = bpf_map_lookup_elem(&xdp_stats_map, &index);
    
    /*if (pkt_count) {

        // We pass every other packet
        if ((*pkt_count)++ & 1)
            return XDP_PASS;
    }*/

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
