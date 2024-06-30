#ifndef COMMON_DEF_H
#define COMMON_DEF_H

#define MAX_NUMBER_CORES 8
#define MAX_NUMBER_FLOWS 20
#define MAX_EVENT_QUEUE_LEN 10

enum event_type {
    APP_EVENT,
    NET_EVENT,
    TIMER_EVENT,
    PROG_EVENT
};

struct flow_id {
    __u8 src_ip;
    __u8 src_port;
    __u8 dest_ip;
    __u8 dest_port;
};

struct hash_key {
    int cpu;
};

struct app_event {
    struct flow_id ev_flow_id;
    __u64 occupied;
    __u64 value;
};

struct net_event {
    struct flow_id ev_flow_id;
    __u64 value;
};

struct timer_event {
    struct flow_id ev_flow_id;
    __u64 value;
};

struct prog_event {
    struct flow_id ev_flow_id;
    __u64 value;
};

struct timer_trigger {
    struct flow_id ev_flow_id;
    __u64 value;
    struct bpf_timer timer;
    //struct xdp_md *packet;
};

struct queue_head_tail {
    __u32 net_head;
    __u32 net_tail;
    __u32 timer_head;
    __u32 timer_tail;
    __u32 prog_head;
    __u32 prog_tail;
};

struct flow_info {
    __u32 len_app_queue;
    __u32 len_net_queue;
    __u32 len_timer_queue;
    __u32 len_prog_queue;
};

struct test {
    int value;
};

#endif