/* SPDX-License-Identifier: GPL-2.0 */
#include <linux/bpf.h>
#include <linux/in.h>
#include <bpf/bpf_helpers.h>
#include <linux/if_ether.h>
#include <linux/ipv6.h>
#include <linux/tcp.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_endian.h>

#define MAX_NUMBER_CORES 12

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, __u32);
    __uint(max_entries, MAX_NUMBER_CORES);
} common_array SEC(".maps");

struct {
    __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
    __type(key, __u32);
    __type(value, __u32);
    __uint(max_entries, MAX_NUMBER_CORES);
} percpu_array SEC(".maps");

struct {
    __uint(type, BPF_MAP_TYPE_ARRAY);
    __type(key, __u32);
    __type(value, __u32);
    __uint(max_entries, MAX_NUMBER_CORES);
} counter_array SEC(".maps");

static __always_inline int update_counter (int key_cpu) {
    int * value = bpf_map_lookup_elem(&counter_array, &key_cpu);
    if(!value)
        return 0;

    bpf_printk("\nCurrent cpu: %d\nCounter: %d", key_cpu, *value);

    int new_value = (* value) + 1;
    bpf_map_update_elem(&counter_array, &key_cpu, &new_value, BPF_ANY);

    return 1;
}

static __always_inline int lookup_map (int key, void * map_pointer) {
    int * value = bpf_map_lookup_elem(map_pointer, &key);

    if(!value)
        return 0;

    bpf_printk("\nCurrent key: %d\nValue: %d", key, *value);

    //int new_value = (* value) + 1;
    //bpf_map_update_elem(map_pointer, &key, &new_value, BPF_ANY);

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

    // Lookup common map
    lookup_map(cpu, &common_array);

    return XDP_DROP;
}

SEC("xdp")
int  percpu_array_lookup(struct xdp_md *ctx)
{
    int cpu = bpf_get_smp_processor_id();

    // Update counter map
    if(!update_counter(cpu)) {
        bpf_printk("Error while looking up counter map");
    }

    // Lookup common map
    lookup_map(0, &percpu_array);

    return XDP_DROP;
}

SEC("xdp")
int  common_array_lookup_same_keys(struct xdp_md *ctx)
{
    int cpu = bpf_get_smp_processor_id();

    // Update counter map
    if(!update_counter(cpu)) {
        bpf_printk("Error while looking up counter map");
    }

    // Lookup common map
    lookup_map(0, &common_array);

    return XDP_DROP;
}

SEC("xdp")
int  simply_drop(struct xdp_md *ctx)
{
    int cpu = bpf_get_smp_processor_id();

    // Update counter map
    if(!update_counter(cpu)) {
        bpf_printk("Error while looking up counter map");
    }

    return XDP_DROP;
}

char _license[] SEC("license") = "GPL";
