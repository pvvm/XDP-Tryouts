#ifndef COMMON_DEF_H
#define COMMON_DEF_H

#define MAX_NUMBER_CORES 8
#define MAX_NUMBER_FLOWS 20
#define MAX_EVENT_QUEUE_LEN 100

struct flow_id {
    __u32 sender_ip;
    __u16 sender_port;
    __u32 receiver_ip;
    __u16 receiver_port;
};

struct hash_key {
    int cpu;
};

struct app_event {
    __u64 occupied;
    __u64 value;
};

#endif