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
//#define MAX_NUM_CTX_PKT_INFO 500
#define MAX_NET_EVENTS 2
#define MUTATED_PACKET_SIZE 2000

//#define SMSS 1440
//#define RTT 100000000 // 100ms
//#define GRANULARITY_G 10000000

enum major_event_type {
    APP_EVENT,
    TIMER_EVENT,
    PROG_EVENT
};

struct flow_id {
    __be32 src_ip;
    __be32 dest_ip;
    __be16 src_port;
    __be16 dest_port;
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

struct timer_data {
    __u64 duration;
};
struct interm_out
{
	__u32 psn;
	__u8 pkt_counter; 
	__u8 remove_counter;
};
struct APPHeader
{
	__u32 qp_id;
	__u32 optype;
	__u32 wr_id;
	__u32 lkey;
	__u8 addr;
	__u32 length;
	__u32 swap_add;
	__u32 compare;
	__u32 rkey;
	__u8 raddr;
	__u32 ack_req;
};
enum minor_event_type {
	SEND_WQE = 1,
	WRITE_WQE,
	RECV_WQE,
	READ_WQE,
	ATOMIC_WQE,
	TRANSMIT_EVENT,
	RECV_DATA,
	WRITE_DATA,
	READ_REQ_DATA,
	READ_RESP_DATA,
	ATOMIC_DATA,
	ATOMIC_ACK,
	RESPONDER_EVENT,
	ACK,
	NACK,
	CNP_CHECK,
	CNP,
	DCQCN_TIMER,
	DCQCN_INCREASE,
	ALPHA_CHECK,
	MISS_ACK,
};
struct AETHeader
{
	__u8 ack;
	__u8 type_nack;
	__u32 credit_count;
	__u32 MSN;
	__u32 RNR_delay;
};
struct AtomicAckETHeader
{
	__u32 original_data;
};
struct AtomicETHeader
{
	__u8 raddr;
	__u32 rkey;
	__u32 swap_add;
	__u32 compare;
};
struct BTHeader
{
	__u32 opcode;
	__u8 ack_req;
	__u32 dest_qp;
	__u32 psn;
};
struct IPHeader
{
	__u8 ecn;
	__u32 identification;
	__u32 flags;
	__u32 ttl;
	__u32 protocol;
	__u32 hdrChecksum;
	__u8 srcAddr;
	__u8 dstAddr;
};
struct RETHeader
{
	__u32 raddr;
	__u32 rkey;
	__u32 length;
};
struct UDPHeader
{
	__u32 src_port;
	__u32 dst_port;
	__u32 length;
	__u32 checksum;
};
struct app_event
{
	enum minor_event_type event_type;
	__u32 ev_flow_id;
	__u32 wr_id;
	__u32 lkey;
	__u8 addr;
	__u32 length;
	__u32 qp_id;
	__u8 ack_req;
	__u32 rkey;
	__u8 raddr;
	__u32 swap_add;
	__u32 compare;
	__u64 occupied;
};
struct net_event
{
	enum minor_event_type event_type;
	__u32 ev_flow_id;
	__u32 qp_id;
	__u32 wr_id;
	__u32 psn;
	__u32 credit_count;
	__u32 MSN;
	__u32 pkt_bytes_size;
	__u8 type_nack;
	__u32 RNR_delay;
	__u8 ack_req;
	__u8 raddr;
	__u32 rkey;
	__u8 ecn;
	__u8 transit_addr;
	__u32 length;
	__u32 opcode;
	__u32 data_len;
	__u32 swap_add;
	__u32 compare;
};
struct timer_event
{
	enum minor_event_type event_type;
	__u32 ev_flow_id;
	__u32 qp_id;
	__u64 valid_bit;
};
struct prog_event
{
	enum minor_event_type event_type;
	__u32 ev_flow_id;
	__u32 qp_id;
	__u32 wr_id;
	__u32 psn;
	__u8 ack_req;
	__u8 addr;
	__u32 length;
};
struct app_metadata
{
	__u8 type_metadata;
	__u8 write_to_mem;
	__u32 fb_type;
	__u32 bytes;
	__u32 type_error;
	__u8 address;
	__u32 offset;
	__u32 length;
	__u8 transit_addr;
};
struct net_metadata
{
	__u8 type_metadata;
	__u32 hdr_combination;
	struct UDPHeader udp;
	struct BTHeader bth;
	struct RETHeader reth;
	struct AETHeader aeth;
	struct AtomicETHeader atom_aeth;
	struct AtomicAckETHeader atom_ack_eth;
	__u8 read_from_mem;
	__u8 address;
	__u32 length;
	__u32 Rc;
};
struct packet_info
{
	struct net_metadata pkt_ev;
	__u32 psn;
	__u8 ack_req;
	__u32 wr_id;
	__u8 acked;
	__u32 SSN;
	__u8 laddr;
};
struct responder_packet_info
{
	struct net_metadata pkt_ev;
	__u32 wr_id;
};
struct work_comp
{
	__u32 wr_id;
	__u32 status;
	__u32 opcode;
	__u32 qp_id;
	__u32 length;
};
struct context
{
	__u32 qp_id;
	__u32 lkey;
	struct app_event SQ_list[500];
	__u32 num_SQ_list;
	struct app_event RQ_list[500];
	__u32 num_RQ_list;
	struct packet_info sent_packets[500];
	__u32 num_sent_packets;
	__u32 transport_timer ;
	__u32 nPSN;
	char CQ[500];
	struct responder_packet_info responder_packets[500];
	__u32 num_responder_packets;
	__u32 ePSN;
	__u32 MSN;
	__u32 credit_count ;
	__u32 recv_first_psn;
	__u32 write_first_psn;
	__u32 SSN ;
	__u32 LSN ;
	__u32 MTU;
	__u32 init_sqn;
	__u32 dest_qp;
	__u32 src_port;
	__u32 dst_port;
	__u32 Rt;
	__u32 Rc;
	__u32 alpha;
	__u32 byte_counter;
	__u32 BC;
	__u32 T1;
	__u32 F;
	__u32 Rai;
	__u32 ecn_found_counter ;
	__u8 first_pkt_connection ;
	struct timer_data timer_ack_timeout;
	struct timer_data timer_cnp;
	struct timer_data timer_alpha;
	struct timer_data timer_DCQCN_counter;
};
struct loop_arg0{
	__u32 index;
	struct app_event * ev;
	struct context * ctx;
	__u32 first_psn;
};
struct loop_arg1{
	__u32 index;
	struct app_event * ev;
	struct context * ctx;
	__u32 first_psn;
};
struct loop_arg2{
	struct net_metadata pkt_ev;
	__u32 i;
	struct app_event * ev;
	struct context * ctx;
};
struct loop_arg3{
	struct context * ctx;
	__u32 i;
	struct interm_out * out;
	struct xdp_md * redirect_pkt;
	__u32 number_packets_sent;
	struct app_event * ev;
};
struct loop_arg4{
	struct context * ctx;
	__u32 i;
	struct interm_out * out;
	struct xdp_md * redirect_pkt;
	__u32 number_packets_sent;
	struct prog_event * ev;
};
struct loop_arg5{
	struct context * ctx;
	__u32 i;
	struct interm_out * out;
	struct xdp_md * redirect_pkt;
	__u32 number_packets_sent;
	struct net_event * ev;
};
struct loop_arg6{
	struct context * ctx;
	__u32 i;
};
struct loop_arg7{
	struct context * ctx;
	struct net_metadata pkt_ev;
	__u32 index;
	struct net_event * ev;
	__u8 last_packet;
};
struct loop_arg8{
	struct context * ctx;
	__u32 i;
	__u32 psn_ack_req;
	struct net_event * ev;
	__u32 pkt_counter;
};
struct loop_arg9{
	struct context * ctx;
	__u32 i;
	__u32 pkt_counter;
};
struct loop_arg10{
	struct context * ctx;
	__u32 i;
	struct net_event * ev;
};
struct loop_arg11{
	struct context * ctx;
	__u32 i;
	struct xdp_md * redirect_pkt;
	__u32 counter_pkts;
};
struct loop_arg12{
	struct context * ctx;
	__u32 i;
	__u32 counter_pkts;
};
struct loop_arg13{
	struct context * ctx;
	__u32 i;
	__u32 psn_ack_req;
	struct net_event * ev;
	__u32 pkt_counter;
};
struct loop_arg14{
	struct context * ctx;
	__u32 i;
	struct net_event * ev;
};
struct loop_arg15{
	struct context * ctx;
	__u32 i;
	__u32 psn_ack_req;
	struct net_event * ev;
	__u32 pkt_counter;
};
struct loop_arg16{
	struct net_event * ev;
	struct context * ctx;
	__u32 i;
	__u32 remove_counter;
};
struct loop_arg17{
	struct context * ctx;
	__u32 i;
	struct interm_out * out;
};
struct loop_arg18{
	struct net_event * ev;
	struct xdp_md * redirect_pkt;
	struct context * ctx;
	__u32 i;
	__u32 remove_counter;
};
enum timer_id {
	timer_ack_timeout,
	timer_cnp,
	timer_alpha,
	timer_DCQCN_counter,
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

struct sched_loop_args {
    struct queue_flow_info *f_info;
    __u32 f_id;
    struct context *ctx;
    struct xdp_md *redirect_pkt;
};

#endif
