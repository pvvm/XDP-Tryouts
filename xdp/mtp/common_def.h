#ifndef COMMON_DEF_H
#define COMMON_DEF_H

#define MAX_NUMBER_CORES 8
#define MAX_NUMBER_FLOWS 20
#define MAX_EVENT_QUEUE_LEN 100

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
    __u32 rx_queue_index;
    __u64 value;
};


struct test {
    int value;
};

#endif