#ifndef COMMON_DEF_H
#define COMMON_DEF_H

#define MAX_NUMBER_CORES 8
#define MAX_NUMBER_FLOWS 20
#define MAX_EVENT_QUEUE_LEN 10
#define MAX_NUM_PROCESSED_EVENTS 3
#define MAX_NUMBER_TIMERS 10
#define NO_TIMER_AVAILABLE 999999
#define MAX_NUMBER_PROG_EVENTS 10
#define MAX_NUM_NET_METADATA 20
#define IS_NET_METADATA 0
#define IS_APP_METADATA 1

enum major_event_type {
    APP_EVENT,
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

struct net_event {
    enum minor_event_type event_type;
    struct flow_id ev_flow_id;
    __u64 value;
};

struct metadata_hdr {
    __u8 src_mac[6];
    __u8 dst_mac[6];
    __be32 src_ip;
    __be32 dst_ip;
    __be16 src_port;
    __be16 dst_port;
    __u16 data_len;
    __u16 metadata_end;
};

struct sched_loop_args {
    struct flow_id f_id;
    __u32 curr_pkt_len;
    struct xdp_md *redirect_pkt;
};

struct app_metadata {
    __u8 type_metadata;
    __u32 value1;
    __u32 value2;
    __u32 value3;
    __u32 value4;
};

struct net_metadata {
    __u8 type_metadata;
    __u32 value1;
    __u16 value2;
};

#endif