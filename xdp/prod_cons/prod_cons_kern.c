/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
#include <linux/in.h>
#include <bpf/bpf_helpers.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>
#include <time.h>

#include "../common/parsing_helpers.h"

struct map_elem {
    int empty;
    int value;
};

struct inner_array {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, struct map_elem);
    __uint(max_entries, 100);
} inner_array0 SEC(".maps"),
inner_array1 SEC(".maps"),
inner_array2 SEC(".maps"),
inner_array3 SEC(".maps"),
inner_array4 SEC(".maps"),
inner_array5 SEC(".maps"),
inner_array6 SEC(".maps"),
inner_array7 SEC(".maps"),
inner_array8 SEC(".maps"),
inner_array9 SEC(".maps");

struct hash_key {
    int cpu;
};

struct outer_hash {
    __uint(type, BPF_MAP_TYPE_HASH_OF_MAPS);
    __type(key, struct hash_key);
    __uint(max_entries, 10);
    __array(values, struct inner_array);
} outer_hash SEC(".maps") = {
    .values = {
        [0] = &inner_array0,
        [1] = &inner_array1,
        [2] = &inner_array2,
        [3] = &inner_array3,
        [4] = &inner_array4,
        [5] = &inner_array5,
        [6] = &inner_array6,
        [7] = &inner_array7,
        [8] = &inner_array8,
        [9] = &inner_array9,
    },
};

SEC("xdp")
int testing_prod_cons(struct xdp_md *ctx)
{
    // Testing arrays
    /*struct hash_key i[5];
    i[0].cpu = 50;
    i[1].cpu = 60;
    i[2].cpu = 54;
    i[3].cpu = 1;
    i[4].cpu = 999;
    bpf_printk("%d", i[1].cpu);*/

    int cpu = bpf_get_smp_processor_id();

    struct hash_key key;
    key.cpu = cpu;

    struct inner_array *inner;
    inner = bpf_map_lookup_elem(&outer_hash, &key);
    if(!inner) {
        bpf_printk("Couldn't get entry of the map");
        return XDP_DROP;
    }

    int inner_map_key = 0;
    struct map_elem *inner_elem = bpf_map_lookup_elem(inner, &inner_map_key);

    if(!inner_elem)
        return 0;

    bpf_printk("%d %d", inner_elem->empty, inner_elem->value);

    return XDP_DROP;
}

char _license[] SEC("license") = "GPL";
