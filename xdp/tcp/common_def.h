#ifndef COMMON_DEF_H
#define COMMON_DEF_H

#define MAX_NUMBER_CORES 1
#define MAX_NUMBER_FLOWS 2000
#define MAX_EVENT_QUEUE_LEN 1000
#define MAX_NUM_PROCESSED_EVENTS 10
#define MAX_NUMBER_TIMERS 10
#define NO_TIMER_AVAILABLE 999999
#define MAX_NUM_NET_METADATA 500
#define IS_NET_METADATA 0
#define IS_APP_METADATA 1
#define MAX_NUM_CTX_PKT_INFO 500
#define MAX_NET_EVENTS 2
#define MUTATED_PACKET_SIZE 2000

#define SMSS 1440
#define RTT 100000000 // 100ms
#define GRANULARITY_G 10000000

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
    DATA,
};

enum timer_id {
    ACK_TIMEOUT,
    EP_TIMER_TEST2,
};

struct flow_id {
    __be32 src_ip;
    __be32 dest_ip;
    __be16 src_port;
    __be16 dest_port;
};

struct app_event {
    enum minor_event_type event_type;
    __u32 ev_flow_id;
    __u32 data_size;
    __u64 occupied;
};

struct net_event {
    enum minor_event_type event_type;
    __u32 ev_flow_id;
    __be32 data_len;
    __be32 ack_seq;
    __be32 seq_num;
    __be16 rwnd_size;
};

struct timer_event {
    enum minor_event_type event_type;
    __u32 ev_flow_id;
    __u32 seq_num;
    __u64 valid_bit;
    //__u32 teste;
};

struct prog_event {
    enum minor_event_type event_type;
    __u32 ev_flow_id;
    __u64 value;
    __u32 teste;
    //__u32 teste1;
};

struct timer_trigger {
    struct bpf_timer timer;
    struct timer_event t_event;
    __u32 triggered;
};

struct timer_trigger_id {
    __u32 f_id;
    __u32 timer_id;
};

struct queue_head_tail {
    __u32 net_head;
    __u32 net_tail;
    __u32 timer_head;
    __u32 timer_tail;
    __u32 prog_head;
    __u32 prog_tail;
};

struct queue_flow_info {
    struct app_info {
        __u32 app_head;
        __u32 app_tail;
        __u32 len_app_queue;
    } app_info;
    struct timer_info {
        __u64 len_timer_queue;
        __u32 timer_head;
        __u32 timer_tail;
        __u64 executing_enqueue;
    } timer_info;
    struct prog_info {
        __u32 len_prog_queue;
        __u32 prog_head;
        __u32 prog_tail;
    } prog_info;
};

struct sent_pkt_info {
    __u32 seq_num;
    __u32 data_len;
};

struct context {
    __be32 last_ack;
    __u8 duplicate_acks;
    __u32 flightsize_dupl;
    __u32 ssthresh;
    __u32 cwnd_size;

    __u64 RTO;
    __s64 SRTT;
    __s64 RTTVAR;
    __u8 first_rto;
    
    // The oldest unacked sequence number
    __u32 send_una;
    // The next sequence number to be sent
    __u32 send_next;
    // Unsent data size
    __u32 data_end;
    __be16 last_rwnd_size;

    // Receive data side
    __be16 rwnd_size;
    __u32 recv_next;
    struct sent_pkt_info data_recv_info_array[MAX_NUM_CTX_PKT_INFO];
    __u16 data_recv_array_head;
    __u16 data_recv_array_tail;
};

struct intermediate_output {
    __u8 change_cwnd;
    __u8 skip_ack_eps;
};

struct sched_loop_args {
    struct queue_flow_info *f_info;
    __u32 f_id;
    struct context *ctx;
    struct xdp_md *redirect_pkt;
};

struct move_pkt_info_head_arg {
    struct context *ctx;
    __be32 ack_seq;
};

struct insert_data_array_args {
    struct context *ctx;
    struct sent_pkt_info new_elem;
    __u32 curr_index;
    __u8 found;
};

struct remove_data_array_args {
    struct context *ctx;
    __u32 recv_next;
    __u32 curr_index;
};

struct send_loop_args {
    __u32 bytes_to_send;
    struct context *ctx;
    struct xdp_md *redirect_pkt;
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
    __u32 cwnd_size;
};

struct app_metadata {
    __u8 type_metadata;
    __u32 seq_num;
    __u32 data_len;
};

struct net_metadata {
    __u8 type_metadata;
    __u32 seq_num;
    __u32 data_len;
    __u8 ack_flag;   // 1 == ACK, 0 == DATA
    __u32 ack_num;
    __be16 wnd_size;
};


#endif