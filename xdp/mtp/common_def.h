#ifndef COMMON_DEF_H
#define COMMON_DEF_H

#define MAX_NUMBER_CORES 8
#define MAX_NUMBER_FLOWS 20
#define MAX_EVENT_QUEUE_LEN 10
#define MAX_NUM_PROCESSED_EVENTS 3
#define MAX_NUMBER_TIMERS 10
#define NO_TIMER_AVAILABLE 999999
#define MAX_NUMBER_PROG_EVENTS 10

enum major_event_type {
    APP_EVENT,
    NET_EVENT,
    TIMER_EVENT,
    PROG_EVENT
};

enum minor_event_type {
    SEND,
    ACK,
    MISS_ACK,
    PROG_TEST,
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
    enum minor_event_type event_type;
    struct flow_id ev_flow_id;
    __u64 occupied;
    __u64 value;
};

struct net_event {
    enum minor_event_type event_type;
    struct flow_id ev_flow_id;
    __u64 value;
};

struct timer_event {
    enum minor_event_type event_type;
    struct flow_id ev_flow_id;
    __u64 value;
};

struct prog_event {
    enum minor_event_type event_type;
    struct flow_id ev_flow_id;
    __u64 value;
};

struct timer_trigger {
    struct bpf_timer timer;
    struct timer_event t_event;
    __u32 cpu_id;
    __u32 triggered;
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
    struct app_info {
        __u32 app_head;
        __u32 net_tail;
        __u32 len_app_queue;
    } app_info;
    struct net_info {
        __u32 net_head;
        __u32 net_tail;
        __u32 len_net_queue;
    } net_info;
    struct timer_info {
        __u32 len_timer_queue;
        __u32 timer_head;
        __u32 timer_tail;
    } timer_info;
    struct prog_info {
        __u32 len_prog_queue;
        __u32 prog_head;
        __u32 prog_tail;
    } prog_info;
};

struct flow_loop_data {
    struct flow_id f_id;
    __u32 len_app_queue;
    __u32 len_net_queue;
    __u32 len_timer_queue;
    __u32 len_prog_queue;
};

struct context {
    __u32 value1;
    __u32 value2;
    __u32 value3;
};

struct intermediate_output {
    __u32 value;
};

struct sched_loop_args {
    __u32 cpu_id;
    struct flow_info *f_info;
};

struct timer_loop_args {
    __u32 index;
};

struct test {
    int value;
};

#endif