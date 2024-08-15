/* SPDX-License-Identifier: GPL-2.0 */

#define _GNU_SOURCE

#include <assert.h>
#include <errno.h>
#include <getopt.h>
#include <locale.h>
#include <poll.h>
#include <pthread.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sched.h>

#include <sys/resource.h>

#include <bpf/bpf.h>
#include <xdp/xsk.h>
#include <xdp/libxdp.h>

#include <arpa/inet.h>
#include <net/if.h>
#include <linux/if_link.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
//#include <linux/icmp.h>
#include <linux/tcp.h>

#include "../common/common_params.h"
#include "../common/common_user_bpf_xdp.h"
#include "../common/common_libbpf.h"

#include "common_def.h"
#include "req_queue.h"
#include "create_packet.h"
#include "idle_flow_list.h"

#define NUM_FRAMES         	4096
#define FRAME_SIZE         	XSK_UMEM__DEFAULT_FRAME_SIZE
#define RX_BATCH_SIZE     	64
#define INVALID_UMEM_FRAME 	UINT64_MAX

#define NUMBER_MOM			3
#define IDLE_TIME			5000000000L
#define ONE_SECOND			1000000000

static const char *default_filename = "kernel_xdp.o";

static const char *default_progname = "net_arrive";

int packets_per_core[8] = {0, 0, 0, 0, 0, 0, 0, 0};

static struct xdp_program *prog;
int xsk_map_fd;
bool custom_xsk = false;

//struct req_queue *cpu_req_queues;
struct req_queue_v2 cpu_req_queues_v2[MAX_NUMBER_CORES];

pthread_mutex_t worker_lock[MAX_NUMBER_CORES];

struct config cfg = {
	.ifindex   = -1,
	.do_unload = false,
};

struct xsk_umem_info {
	struct xsk_ring_prod fq;
	struct xsk_ring_cons cq;
	struct xsk_umem *umem;
	void *buffer;
};
struct stats_record {
	uint64_t timestamp;
	uint64_t rx_packets;
	uint64_t rx_bytes;
	uint64_t tx_packets;
	uint64_t tx_bytes;
};
struct xsk_socket_info {
	struct xsk_ring_cons rx;
	struct xsk_ring_prod tx;
	struct xsk_umem_info *umem;
	struct xsk_socket *xsk;

	uint64_t umem_frame_addr[NUM_FRAMES];
	uint32_t umem_frame_free;

	uint32_t outstanding_tx;

	uint32_t cpu_id;

	struct stats_record stats;
	struct stats_record prev_stats;
};

struct worker_argument {
	struct config *cfg;
	struct xsk_socket_info *xsk_socket;
	int prod_map_fd;
	int tail_map_fd;
};

struct idle_checker_argument {
	struct xsk_socket_info *xsk_socket;
	int flow_info_fd;
	int tail_map_fd;
};

struct mom_map_info {
	char name[40];
	int size;
	int num_elements;
};

struct mom_map_info mm_info[NUMBER_MOM] =
								{{"outer_app_hash", sizeof(struct app_event), MAX_EVENT_QUEUE_LEN},
								{"outer_timer_hash", sizeof(struct timer_event), MAX_EVENT_QUEUE_LEN},
								{"outer_prog_hash", sizeof(struct prog_event), MAX_EVENT_QUEUE_LEN}};


static inline __u32 xsk_ring_prod__free(struct xsk_ring_prod *r)
{
	r->cached_cons = *r->consumer + r->size;
	return r->cached_cons - r->cached_prod;
}

static const char *__doc__ = "AF_XDP kernel bypass example\n";

static const struct option_wrapper long_options[] = {
	{{"help",        no_argument,		NULL, 'h' },
	 "Show help", false},

	{{"dev",         required_argument,	NULL, 'd' },
	 "Operate on device <ifname>", "<ifname>", true},

	{{"skb-mode",    no_argument,		NULL, 'S' },
	 "Install XDP program in SKB (AKA generic) mode"},

	{{"native-mode", no_argument,		NULL, 'N' },
	 "Install XDP program in native mode"},

	{{"auto-mode",   no_argument,		NULL, 'A' },
	 "Auto-detect SKB or native mode"},

	{{"unload",      required_argument,	NULL, 'U' },
	 "Unload XDP program <id> instead of loading", "<id>"},

	{{"unload-all",  no_argument,           NULL,  4  },
	 "Unload all XDP programs on device"},

	{{"quiet",       no_argument,		NULL, 'q' },
	 "Quiet mode (no output)"},

	{{"filename",    required_argument,	NULL,  1  },
	 "Load program from <file>", "<file>"},

	{{"progname",    required_argument,	NULL,  2  },
	 "Load program from function <name> in the ELF file", "<name>"},

	{{0, 0, NULL,  0 }}
};

static bool global_exit;


int find_map_fd(struct bpf_object *bpf_obj, const char *mapname)
{
	struct bpf_map *map;
	int map_fd = -1;

	/* Lesson#3: bpf_object to bpf_map */
	map = bpf_object__find_map_by_name(bpf_obj, mapname);
        if (!map) {
		fprintf(stderr, "ERR: cannot find map by name: %s\n", mapname);
		goto out;
	}

	map_fd = bpf_map__fd(map);
 out:
	return map_fd;
}

/*
 * Function that initializes a memory buffer to serve as
 * the AF_XDP UMEM
 */
static struct xsk_umem_info *configure_xsk_umem(void *buffer, uint64_t size)
{
	struct xsk_umem_info *umem;
	int ret;

	umem = calloc(1, sizeof(*umem));
	if (!umem)
		return NULL;

	/*struct xsk_umem_config xsk_umem_cfg = {
//		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS * 2,
		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
		.frame_headroom = 256,
		//.frame_headroom = 0,
		.flags = 0
	};*/

	/* Allocates a UMEM by taking the buffer, its size, and the fill and completion queues */
	ret = xsk_umem__create(&umem->umem, buffer, size, &umem->fq, &umem->cq,
			       NULL/*&xsk_umem_cfg*/);
	if (ret) {
		errno = -ret;
		return NULL;
	}

	umem->buffer = buffer;
	return umem;
}

static uint64_t xsk_alloc_umem_frame(struct xsk_socket_info *xsk)
{
	uint64_t frame;
	if (xsk->umem_frame_free == 0)
		return INVALID_UMEM_FRAME;

	frame = xsk->umem_frame_addr[--xsk->umem_frame_free];
	xsk->umem_frame_addr[xsk->umem_frame_free] = INVALID_UMEM_FRAME;
	return frame;
}

static void xsk_free_umem_frame(struct xsk_socket_info *xsk, uint64_t frame)
{
	assert(xsk->umem_frame_free < NUM_FRAMES);

	xsk->umem_frame_addr[xsk->umem_frame_free++] = frame;
}

static uint64_t xsk_umem_free_frames(struct xsk_socket_info *xsk)
{
	return xsk->umem_frame_free;
}


/* Function that initializes an XSK socket (used by AF_XDP). Takes
 * the configuration of the XDP program and the UMEM
 */
static struct xsk_socket_info *xsk_configure_socket(struct config *cfg,
						    struct xsk_umem_info *umem)
{
	struct xsk_socket_config xsk_cfg;
	struct xsk_socket_info *xsk_info;
	uint32_t idx;
	int i;
	int ret;
	uint32_t prog_id;

	xsk_info = calloc(1, sizeof(*xsk_info));
	if (!xsk_info)
		return NULL;

	xsk_info->umem = umem;
	xsk_cfg.rx_size = XSK_RING_CONS__DEFAULT_NUM_DESCS;
	xsk_cfg.tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
	xsk_cfg.xdp_flags = cfg->xdp_flags;
	//cfg->xsk_bind_flags &= ~XDP_ZEROCOPY;
	//cfg->xsk_bind_flags |= XDP_COPY;
	xsk_cfg.bind_flags = cfg->xsk_bind_flags;
	xsk_cfg.libbpf_flags = (custom_xsk) ? XSK_LIBBPF_FLAGS__INHIBIT_PROG_LOAD: 0;

	/* Creates socket, storing its address in xsk_info->xsk */
	ret = xsk_socket__create(&xsk_info->xsk, cfg->ifname,
				 cfg->xsk_if_queue, umem->umem, &xsk_info->rx,
				 &xsk_info->tx, &xsk_cfg);
	if (ret)
		goto error_exit;

	if (custom_xsk) {
		/* Updates XSK map with this new XSK socket */
		ret = xsk_socket__update_xskmap(xsk_info->xsk, xsk_map_fd);
		if (ret)
			goto error_exit;
	} else {
		/* Getting the program ID must be after the xdp_socket__create() call */
		if (bpf_xdp_query_id(cfg->ifindex, cfg->xdp_flags, &prog_id))
			goto error_exit;
	}

	/* Stores the addresses of UMEM frame into an array */
	for (i = 0; i < NUM_FRAMES; i++)
		xsk_info->umem_frame_addr[i] = i * FRAME_SIZE;

	xsk_info->umem_frame_free = NUM_FRAMES;

	/* Stuff the receive path with buffers, we assume we have enough */
	/* This function reserves space in the fill queue of UMEM */
	ret = xsk_ring_prod__reserve(&xsk_info->umem->fq,
				     XSK_RING_PROD__DEFAULT_NUM_DESCS,
				     &idx);

	if (ret != XSK_RING_PROD__DEFAULT_NUM_DESCS)
		goto error_exit;

	/* Gets the free UMEM frames adresses and sets them in the fill ring */
	for (i = 0; i < XSK_RING_PROD__DEFAULT_NUM_DESCS; i++)
		*xsk_ring_prod__fill_addr(&xsk_info->umem->fq, idx++) =
			xsk_alloc_umem_frame(xsk_info);

	/* After the frames are properly reserved and allocated, the application
	 * submits them, which indicates to the kernel they are ready to be used
	 i.e. from the head until head + XSK_RING_PROD__DEFAULT_NUM_DESCS, these
	 frames are available for the kernel to use
	 */
	xsk_ring_prod__submit(&xsk_info->umem->fq,
			      XSK_RING_PROD__DEFAULT_NUM_DESCS);

	return xsk_info;

error_exit:
	errno = -ret;
	return NULL;
}

static void complete_tx(struct xsk_socket_info *xsk)
{
	unsigned int completed;
	uint32_t idx_cq;

	if (!xsk->outstanding_tx)
		return;

	sendto(xsk_socket__fd(xsk->xsk), NULL, 0, MSG_DONTWAIT, NULL, 0);

	/* Collect/free completed TX buffers */
	completed = xsk_ring_cons__peek(&xsk->umem->cq,
					XSK_RING_CONS__DEFAULT_NUM_DESCS,
					&idx_cq);
	//printf("CPU: %d Completed %d\n", sched_getcpu(), completed);

	if (completed > 0) {
		for (int i = 0; i < completed; i++) {
			const __u64 * teste = xsk_ring_cons__comp_addr(&xsk->umem->cq,
								      idx_cq++);
			//printf("Completion address: %llu\n", *teste);
			xsk_free_umem_frame(xsk,
					    *teste);
		}

		xsk_ring_cons__release(&xsk->umem->cq, completed);
		xsk->outstanding_tx -= completed < xsk->outstanding_tx ?
			completed : xsk->outstanding_tx;
		
		packets_per_core[sched_getcpu()] += completed;
	}
}

static bool submit_multiple_pkts(struct xsk_socket_info *xsk, struct metadata_hdr *meta_hdr,
	struct net_metadata *array_net_meta[], int num_pkts_send) {

	uint32_t tx_idx = 0;

	/* 	First we check whether we have enough space to allocate
		all required frames, and we get a pointer to the frames
		if no problems happen
	*/
	__u64 frame_address[num_pkts_send];
	uint8_t *area_mem[num_pkts_send];
	for(int i = 0; i < num_pkts_send; i++) {
		frame_address[i] = xsk_alloc_umem_frame(xsk);
		area_mem[i] = xsk_umem__get_data(xsk->umem->buffer, frame_address[i]);
		if(!area_mem[i]) {
			for(int j = 0; j <= i; j++)
				xsk_free_umem_frame(xsk, frame_address[j]);
			return false;
		}
	}

	int ret = xsk_ring_prod__reserve(&xsk->tx, num_pkts_send, &tx_idx);
	if (!ret) {
		/* No more transmit slots, drop the packet */
		return false;
	}

	for(int i = 0; i < num_pkts_send; i++) {
		struct pkt_info p_info = set_pkt_info(*meta_hdr, *array_net_meta[i]);
		//printf("New destination port: %d\n", ntohs(p_info.dst_port));

		unsigned char pkt[1500];
		size_t data_len = 0;
		create_packet(pkt, &data_len, p_info, NULL);

		memcpy(area_mem[i], pkt, data_len);

		xsk_ring_prod__tx_desc(&xsk->tx, tx_idx)->addr = frame_address[i];
		xsk_ring_prod__tx_desc(&xsk->tx, tx_idx++)->len = data_len;

		xsk->outstanding_tx++;
		xsk->stats.tx_bytes += data_len;
		xsk->stats.tx_packets++;
	}

	xsk_ring_prod__submit(&xsk->tx, num_pkts_send);

	return true;
}

static bool process_packet(uint8_t *pkt, struct xsk_socket_info *xsk) {

	if (pkt) {
		struct metadata_hdr *meta_hdr = (struct metadata_hdr *) pkt;
		unsigned char data[1500];
		memcpy(data, pkt + sizeof(struct metadata_hdr), meta_hdr->data_len);

		struct net_metadata *array_net_meta[MAX_NUM_NET_METADATA];
		int counter_net_meta = 0;

		int curr_start = sizeof(struct metadata_hdr) + meta_hdr->data_len;
		while(curr_start < meta_hdr->metadata_end) {
			__u8 *app_or_net = (__u8 *) (pkt + curr_start);
			//printf("%d\n", *app_or_net);

			if(*app_or_net == IS_APP_METADATA) {
				printf("APP ");
				struct app_metadata *app_meta = (struct app_metadata *) (pkt + curr_start);
				printf("%d %d %d\n", app_meta->type_metadata, app_meta->seq_num, app_meta->data_len);
				curr_start += sizeof(*app_meta);

			} else if (*app_or_net == IS_NET_METADATA) {
				printf("NET ");
				struct net_metadata *net_meta = (struct net_metadata *) (pkt + curr_start);
				printf("%d %d %d\n", net_meta->type_metadata, net_meta->seq_num, net_meta->data_len);
				curr_start += sizeof(*net_meta);

				array_net_meta[counter_net_meta] = net_meta;
				counter_net_meta++;

			} else {
				printf("Invalid metadata\n");
				return false;
			}
		}
		return submit_multiple_pkts(xsk, meta_hdr, array_net_meta, counter_net_meta);
	}

	return false;
}

static void handle_receive_packets(struct xsk_socket_info *xsk)
{
	unsigned int rcvd, stock_frames, i;
	uint32_t idx_rx = 0, idx_fq = 0;
	int ret;

	/* Checks the number of packets arriving in RX ring.
	 * With RX_BATCH_SIZE being the largest possible value
	 */
	rcvd = xsk_ring_cons__peek(&xsk->rx, RX_BATCH_SIZE, &idx_rx);

	if (!rcvd)
		return;

	/* Stuff the ring with as many frames as possible */
	/* Gets the number of available entries in fill ring*/
	stock_frames = xsk_prod_nb_free(&xsk->umem->fq,
					xsk_umem_free_frames(xsk));

	if (stock_frames > 0) {
		/* Reserves a number of entries in fill ring */
		ret = xsk_ring_prod__reserve(&xsk->umem->fq, stock_frames,
					     &idx_fq);

		/* This should not happen, but just in case */
		while (ret != stock_frames)
			ret = xsk_ring_prod__reserve(&xsk->umem->fq, rcvd,
						     &idx_fq);

		/* For each one of the reserved entries of fill ring
		 * we allocate a UMEM frame and sets its address to fill ring
		 */
		for (i = 0; i < stock_frames; i++) {
			__u64 teste = xsk_alloc_umem_frame(xsk);
			//printf("Frame address: %llu\n", teste);
			*xsk_ring_prod__fill_addr(&xsk->umem->fq, idx_fq++) =
				teste;
		}

		/* After everything has been written to fill ring,
		 * indicates to the kernel that the application can submit
		 * these entries
		 */
		xsk_ring_prod__submit(&xsk->umem->fq, stock_frames);
	}

	pthread_mutex_lock(&worker_lock[xsk->cpu_id]);
	/* Process received packets */
	for (i = 0; i < rcvd; i++) {
		/* Gets information about an entry of the RX ring */
		uint64_t addr = xsk_ring_cons__rx_desc(&xsk->rx, idx_rx)->addr;
		uint32_t len = xsk_ring_cons__rx_desc(&xsk->rx, idx_rx++)->len;
		//printf("RX ADDRESS: %ld\n", addr);

		uint8_t *pkt = xsk_umem__get_data(xsk->umem->buffer, addr);
		if (!process_packet(pkt, xsk))
			xsk_free_umem_frame(xsk, addr);

		xsk->stats.rx_bytes += len;
	}

	xsk_ring_cons__release(&xsk->rx, rcvd);
	xsk->stats.rx_packets += rcvd;

	/* Do we need to wake up the kernel for transmission */
	complete_tx(xsk);

	pthread_mutex_unlock(&worker_lock[xsk->cpu_id]);
}

static void send_packet_directly(struct xsk_socket_info *xsk) {
	unsigned char pkt[1500];
    size_t data_len = 0;
    
    struct pkt_info p_info = temporary_default_info_send();
    create_packet(pkt, &data_len, p_info, NULL);
	//printf("\n%lu", data_len);

	uint32_t tx_idx = 0;

	pthread_mutex_lock(&worker_lock[xsk->cpu_id]);
	__u64 frame_address = xsk_alloc_umem_frame(xsk);
	//printf("CPU: %d, Address: %llu\n", sched_getcpu(), frame_address);
	uint8_t *area_mem = xsk_umem__get_data(xsk->umem->buffer, frame_address);
	if(!area_mem) {
		xsk_free_umem_frame(xsk, frame_address);
		return;
	}

	int ret = xsk_ring_prod__reserve(&xsk->tx, 1, &tx_idx);
	if (ret != 1) {
		/* No more transmit slots, drop the packet */
		return;
	}

	memcpy(area_mem, pkt, data_len);
	xsk_ring_prod__tx_desc(&xsk->tx, tx_idx)->addr = frame_address;
	xsk_ring_prod__tx_desc(&xsk->tx, tx_idx)->len = data_len;
	xsk_ring_prod__submit(&xsk->tx, 1);

	xsk->outstanding_tx++;
	xsk->stats.tx_bytes += data_len;
	xsk->stats.tx_packets++;

	complete_tx(xsk);
	pthread_mutex_unlock(&worker_lock[xsk->cpu_id]);
}

void produce_app_events(int cpu_id, int outer_map_fd, int tail_map_fd,
	int *inner_index, atomic_uint * last_head) {

	int inner_id, inner_fd, err;
	
	struct app_event old_entry;

	// This function is working properly, since it also enqueues based on the occupied bit.
	// So, even if two CPUs receive requests to the same flow, one of them will be blocked
	// unless they are currently in the same head position

	//struct app_event* new_entry = read_first_req(cpu_req_queues, cpu_id);
	atomic_uint curr_head;
	//struct app_req_info* req_info = read_first_req_v2(&cpu_req_queues_v2[cpu_id], &curr_head);
	//struct app_event* new_entry = &req_info->event;
	struct app_event* new_entry = read_first_req_v2(&cpu_req_queues_v2[cpu_id], &curr_head);
	if(new_entry == NULL/* || curr_head == *last_head*/)
		return;

	// Question: where should we add new entries? In the main thread, when a flow is established,
	// or here in the worker thread?
	// Add new entry to idle flow info
	/*if(!find_idle_flow_info(cpu_id, req_info->event.ev_flow_id)) {
		struct queue_flow_info f_info;
		err = bpf_map_lookup_elem(flow_info_fd, &new_entry->ev_flow_id, &f_info);
		if(err < 0) {
			printf("Couldn't find entry from queue flow info map\n");
			return;
		}
		add_idle_flow_info(cpu_id, *req_info, f_info);
	}*/

	*last_head = curr_head;

	err = bpf_map_lookup_elem(outer_map_fd, &(new_entry->ev_flow_id), &inner_id);
	if(err < 0) {
		printf("Couldn't find entry of outer map\n");
		return;
	}
	//printf("%d %d %d %d", new_entry->ev_flow_id.src_ip, new_entry->ev_flow_id.dest_ip, new_entry->ev_flow_id.src_port, new_entry->ev_flow_id.dest_port);

	inner_fd = bpf_map_get_fd_by_id(inner_id);

	err = bpf_map_lookup_elem(inner_fd, inner_index, &old_entry);
	if(err < 0) {
		printf("Couldn't find entry of inner map\n");
		close(inner_fd);
		return;
	}

	int next_index;
	if(*inner_index < MAX_EVENT_QUEUE_LEN - 1)
		next_index = *inner_index + 1;
	else
		next_index = 0;
	
	// This allows us to always have head and tail with different values
	// and makes app queue behave like a regular circular queue
	struct app_event next_entry;
	err = bpf_map_lookup_elem(inner_fd, &next_index, &next_entry);
	if(err < 0) {
		printf("Couldn't find entry of inner map\n");
		close(inner_fd);
		return;
	}
	//printf("Next %d occupied? %lld\n", next_index, next_entry.occupied);

	//printf("Old entry CPU %d: %lld %lld\n", cpu_id, old_entry.occupied, old_entry.value);

	if(!old_entry.occupied && !next_entry.occupied) {
		err = bpf_map_update_elem(inner_fd, inner_index, new_entry, BPF_ANY);
		if(err < 0) {
			printf("Couldn't update entry of inner map\n");
			close(inner_fd);
			return;
		}
		*inner_index = next_index;
		
		err = bpf_map_update_elem(tail_map_fd, &(new_entry->ev_flow_id), inner_index, BPF_ANY);
		if(err < 0) {
			printf("Couldn't update entry of tail map\n");
			close(inner_fd);
			return;
		}
		/*int teste;
		bpf_map_lookup_elem(tail_map_fd, &(new_entry->ev_flow_id), &teste);

		printf("Inner index %d\n", teste);*/
		
		//req_dequeue(cpu_req_queues, cpu_id);
		req_dequeue_v2(&cpu_req_queues_v2[cpu_id]);
	}
	// VERY IMPORTANT (bpf_map_get_fd_by_id keep returning an increasing value if not used)
	close(inner_fd);
}

void * producer_and_afxdp(void *arg) {
	struct worker_argument *info = (struct worker_argument *) arg;
	struct config *cfg = info->cfg;
	struct xsk_socket_info *xsk_socket = info->xsk_socket;
	int prod_map_fd = info->prod_map_fd;
	int tail_map_fd = info->tail_map_fd;

	struct pollfd fds[2];
	int ret, nfds = 1;

	memset(fds, 0, sizeof(fds));
	/* Gets file descriptor of XSK socket */
	fds[0].fd = xsk_socket__fd(xsk_socket->xsk);
	fds[0].events = POLLIN;

	int inner_index = 0;
	
	atomic_uint last_head = 99999999;
	while(!global_exit) {
		produce_app_events(xsk_socket->cpu_id, prod_map_fd, tail_map_fd, &inner_index, &last_head);

		if (cfg->xsk_poll_mode) {
			ret = poll(fds, nfds, -1);
			if (ret <= 0 || ret > 1)
				continue;
		}
		handle_receive_packets(xsk_socket);

		if(0)
		send_packet_directly(xsk_socket);
		
		//sleep(1);
	}
	free(info);
	pthread_exit(NULL);
}

void trigger_idle_flow(struct pkt_info p_info, struct xsk_socket_info *xsk) {
	unsigned char data[1500];
	unsigned char buf[5000];
	size_t data_len = 0;

	// Note: I'm setting this value to represent a fake packet
	int ip_id = 65535;
	create_packet(data, &data_len, p_info, &ip_id);
	//struct iphdr *ip_hdr = (struct iphdr *) data + sizeof(struct ethhdr);

	LIBBPF_OPTS(bpf_test_run_opts, opts);
	opts.data_in = data;
	opts.data_out = buf;
	opts.data_size_in = data_len;
	opts.data_size_out = 5000;
	opts.flags = 0;

	int err = xdp_program__test_run(prog, &opts, 0);
	if (err != 0) {
		printf("[error]: bpf test run failed: %d\n", err);
	}
	//struct metadata_hdr *meta_hdr = (struct metadata_hdr *) buf;
	//struct metadata_hdr meta_hdr;
	//memcpy(&meta_hdr, buf, sizeof(meta_hdr));

	pthread_mutex_lock(&worker_lock[xsk->cpu_id]);
	process_packet(buf, xsk);
	complete_tx(xsk);
	pthread_mutex_unlock(&worker_lock[xsk->cpu_id]);
}

void * idle_checker(void *arg) {
	struct idle_checker_argument *info = (struct idle_checker_argument *) arg;
	int tail_map_fd = info->tail_map_fd;
	int flow_info_fd = info->flow_info_fd;
	struct xsk_socket_info *xsk_socket = info->xsk_socket;

	struct timespec curr_time;
	long ns_time;
	int num_flows, err;
	struct flow_id f_id;
	int cpu_id = sched_getcpu();
	struct queue_flow_info curr_f_info, old_f_info;
	__u32 curr_queue_tail;


	while(!global_exit) {
		num_flows = num_idle_flow_array[cpu_id];

		for(int i = 0; i < num_flows; i++) {
			f_id = idle_flow_array[cpu_id][i].f_id;
			old_f_info = idle_flow_array[cpu_id][i].q_flow_info;
			clock_gettime(CLOCK_MONOTONIC, &curr_time);
			ns_time = curr_time.tv_sec * 1000000000L + curr_time.tv_nsec;

			//printf("%ld\n", ns_time - idle_flow_array[cpu_id][i].last_time);
			if(ns_time - idle_flow_array[cpu_id][i].last_time > IDLE_TIME) {
				
				err = bpf_map_lookup_elem(flow_info_fd, &f_id, &curr_f_info);
				if(err < 0) {
					printf("Couldn't find entry from queue flow info map\n");
					break;
				}
				
				//struct timespec test, test1;
				//clock_gettime(CLOCK_MONOTONIC, &test);
				err = bpf_map_lookup_elem(tail_map_fd, &f_id, &curr_queue_tail);
				if(err < 0) {
					printf("Couldn't find entry from queue flow info map\n");
					break;
				}
				//clock_gettime(CLOCK_MONOTONIC, &test1);
				//printf("Lookup %ld\n", (test1.tv_sec * 1000000000L + test1.tv_nsec)-(test.tv_sec * 1000000000L + test.tv_nsec));

				//clock_gettime(CLOCK_MONOTONIC, &test);
				if(!empty_queues(curr_f_info, curr_queue_tail) && cmp_queue_flow_info(curr_f_info, old_f_info)) {
					trigger_idle_flow(idle_flow_array[cpu_id][i].p_info, xsk_socket);
				}
				//clock_gettime(CLOCK_MONOTONIC, &test1);
				//printf("BPF_PROG_RUN %ld\n", (test1.tv_sec * 1000000000L + test1.tv_nsec)-(test.tv_sec * 1000000000L + test.tv_nsec));

				idle_flow_array[cpu_id][i].last_time = ns_time;

				// Question: should we automatically update the last flow info right after
				// possibly changing the flow info?
				err = bpf_map_lookup_elem(flow_info_fd, &f_id, &curr_f_info);
				if(err < 0) {
					printf("Couldn't find entry from queue flow info map\n");
					break;
				}
				idle_flow_array[cpu_id][i].q_flow_info = curr_f_info;
			}
		}
		sleep(1);
	}
	free(info);
	pthread_exit(NULL);
}

int set_initial_app_queue_tail(struct flow_id f_id, int app_queue_tail_fd) {
	__u32 tail = 0;
	int err = bpf_map_update_elem(app_queue_tail_fd, &f_id, &tail, BPF_ANY);
	if(err < 0) {
		printf("Error while updating app queue tail entry %d", err);
		return 0;
	}
	return 1;
}

int set_initial_ctx_values(struct flow_id f_id, int context_fd) {
	struct context new_ctx;
	new_ctx.last_ack = 4294967295;
	new_ctx.repeated_acks = 0;
	new_ctx.ssthresh = 999999999;
	new_ctx.cwnd_size = 3 * SMSS;
	new_ctx.RTO = ONE_SECOND;
	new_ctx.SRTT = 0;
	new_ctx.RTTVAR = 0;
	new_ctx.first_rto = 1;
	new_ctx.pkt_array_head = 0;
	new_ctx.pkt_array_tail = 0;
	new_ctx.segment_size = 0;
	new_ctx.send_una = 0;
	new_ctx.send_next = 0;
	new_ctx.data_end = 0;
	new_ctx.rwnd_size = 16959;
	new_ctx.recv_next = 0;
	new_ctx.data_recv_info_array[0].seq_num = 0;
	new_ctx.data_recv_info_array[0].data_len = 0;
	new_ctx.data_recv_array_head = 0;
	new_ctx.data_recv_array_tail = 0;
	int err = bpf_map_update_elem(context_fd, &f_id, &new_ctx, BPF_ANY);
	if(err < 0) {
		printf("Error while updating context entry %d", err);
		return 0;
	}
	return 1;
}

int set_initial_queue_flow_info(struct flow_id f_id, struct pkt_info p_info, int flow_info_fd, int cpu_id) {
	struct queue_flow_info new_flow_info = {{0, 0, 0}, {0, 0, 0, 0}, {0, 0, 0}};
	int err = bpf_map_update_elem(flow_info_fd, &f_id, &new_flow_info, BPF_ANY);
	if(err < 0) {
		printf("Error while updating queue flow info entry %d", err);
		return 0;
	}
	// Adds entry to idle flow information array
	add_idle_flow_info(cpu_id, p_info, f_id, new_flow_info);
	return 1;
}

int set_mom_flow_entry(struct flow_id f_id, int *map_fds) {
	int inner_fd;
	for(int i = 0; i < NUMBER_MOM; i++) {
		inner_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(__u32), mm_info[i].size, mm_info[i].num_elements, 0);
		if(inner_fd < 0) {
			printf("Error while creating inner array for M-of-M %s\n", mm_info[i].name);
			close(inner_fd);
			return 0;
		}
		int err = bpf_map_update_elem(map_fds[i], &f_id, &inner_fd, BPF_ANY);
		if(err < 0) {
			printf("Error while updating outer map %s %d\n", mm_info[i].name, err);
			close(inner_fd);
			return 0;
		}
		close(inner_fd);
	}

	return 1;
}

void distribute_requests(int *map_fds, int context_fd, int flow_info_fd, int tail_map_fd) {

	struct pkt_info p_info = temporary_default_info_rcv();
	struct flow_id f_id = convert_pktinfo_to_flow_id(p_info);
	init_idle_flow_array();
	//printf("%d %d %d %d\n", f_id.src_ip, f_id.dest_ip, f_id.src_port, f_id.dest_port);

	// Initialize maps and arrays of a flow
	if(!set_mom_flow_entry(f_id, map_fds))
		return;
	if(!set_initial_ctx_values(f_id, context_fd))
		return;
	// Note: at the moment I'm always setting the idle flow info to CPU 0 array,
	// but we'll vary when we are able to know to which CPU a flow should go
	if(!set_initial_queue_flow_info(f_id, p_info, flow_info_fd, 0))
		return;
	if(!set_initial_app_queue_tail(f_id, tail_map_fd))
		return;

	init_queue_v2(cpu_req_queues_v2);

	// Note: at this moment the flow_id is fixed to this one
	struct app_event event = {SEND, f_id, SMSS * 2, 1};
	int cpu_to_send = 0;
	while(1) {
		if(!scanf("%d", &cpu_to_send))
			return;
		if(cpu_to_send < 0 || cpu_to_send >= MAX_NUMBER_CORES)
			break;

		//req_enqueue(cpu_req_queues, event, cpu_to_send);
		req_enqueue_v2(&cpu_req_queues_v2[cpu_to_send], event);
		//print_queue(cpu_req_queues);
		print_queue_v2(cpu_req_queues_v2);
	}
	//free_queue(cpu_req_queues);
}

int get_all_map_fd(int *map_fds, int *tail_app_fd, int *context_fd, int *f_info_fd) {

	for(int i = 0; i < NUMBER_MOM; i++) {
		map_fds[i] = find_map_fd(xdp_program__bpf_obj(prog), mm_info[i].name);
		if(map_fds[i] < 0)
			return 0;
	}

	*tail_app_fd = find_map_fd(xdp_program__bpf_obj(prog), "tail_app_hash");
	if(*tail_app_fd < 0)
		return 0;

	*context_fd = find_map_fd(xdp_program__bpf_obj(prog), "context_hash");
	if(*context_fd < 0)
		return 0;

	*f_info_fd = find_map_fd(xdp_program__bpf_obj(prog), "queue_flow_info_hash");
	if(*f_info_fd < 0)
		return 0;

	return 1;
}

static void exit_application(int signal)
{
	int err;

	cfg.unload_all = true;
	err = do_unload(&cfg);
	if (err) {
		fprintf(stderr, "Couldn't detach XDP program on iface '%s' : (%d)\n",
			cfg.ifname, err);
	}

	signal = signal;
	global_exit = true;

	int pkt_sum = 0;
	for(int i = 0; i < 8; i++) {
		pkt_sum += packets_per_core[i];
	}
	printf("Total num packets sent: %d\n", pkt_sum);
}

int main(int argc, char **argv)
{
	//int ret;
	void *packet_buffer[MAX_NUMBER_CORES];
	uint64_t packet_buffer_size;
	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
	DECLARE_LIBXDP_OPTS(xdp_program_opts, xdp_opts, 0);
	struct rlimit rlim = {RLIM_INFINITY, RLIM_INFINITY};
	struct xsk_umem_info *umem[MAX_NUMBER_CORES];
	struct xsk_socket_info *xsk_socket[MAX_NUMBER_CORES];
	//pthread_t stats_poll_thread[MAX_NUMBER_CORES];
	int err;
	char errmsg[1024];

	/* Global shutdown handler */
	signal(SIGINT, exit_application);

	/* Set default BPF-ELF object file and BPF program name */
	strncpy(cfg.filename, default_filename, sizeof(cfg.filename));
	strncpy(cfg.progname,  default_progname,  sizeof(cfg.progname));

	/* Cmdline options can change progname */
	parse_cmdline_args(argc, argv, long_options, &cfg, __doc__);

	/* Required option */
	if (cfg.ifindex == -1) {
		fprintf(stderr, "ERROR: Required option --dev missing\n\n");
		usage(argv[0], __doc__, long_options, (argc == 1));
		return EXIT_FAIL_OPTION;
	}

	/* Unload a program by prog_id, or
    * unload all programs on net device
    */
	if (cfg.do_unload || cfg.unload_all) {
		err = do_unload(&cfg);
		if (err) {
			libxdp_strerror(err, errmsg, sizeof(errmsg));
			fprintf(stderr, "Couldn't unload XDP program %d: %s\n",
				cfg.prog_id, errmsg);
			return err;
		}

		printf("Success: Unloading XDP prog name: %s\n", cfg.progname);
		return EXIT_OK;
	}

	/* Load custom program if configured */
	/* Everything here can be sumarized by load_bpf_and_xdp_attach in common,
	*  except the xsk map part
	*/
	if (cfg.filename[0] != 0) {
		custom_xsk = true;
		xdp_opts.open_filename = cfg.filename;
		xdp_opts.prog_name = cfg.progname;
		xdp_opts.opts = &opts;

		/* Load XDP program */
		if (cfg.progname[0] != 0) {
			xdp_opts.open_filename = cfg.filename;
			xdp_opts.prog_name = cfg.progname;
			xdp_opts.opts = &opts;

			prog = xdp_program__create(&xdp_opts);
		} else {
			prog = xdp_program__open_file(cfg.filename,
						  NULL, &opts);
		}
		err = libxdp_get_error(prog);
		if (err) {
			libxdp_strerror(err, errmsg, sizeof(errmsg));
			fprintf(stderr, "ERR: loading program: %s\n", errmsg);
			return err;
		}

		/* At this point: BPF-progs are (only) loaded by the kernel, and prog_fd
		 * is file-descriptor handle. Next step is attaching this FD
		 * to a kernel hook point, in this case XDP net_device link-level hook.
		 */
		err = xdp_program__attach(prog, cfg.ifindex, cfg.attach_mode, 0);
		if (err) {
			libxdp_strerror(err, errmsg, sizeof(errmsg));
			fprintf(stderr, "Couldn't attach XDP program on iface '%s' : %s (%d)\n",
				cfg.ifname, errmsg, err);
			return err;
		}

		/* We also need to load the xsks_map */
		xsk_map_fd = find_map_fd(xdp_program__bpf_obj(prog), "xsks_map");
        if (xsk_map_fd < 0) {
            exit(EXIT_FAIL_BPF);
        }

	}

	/* Allow unlimited locking of memory, so all memory needed for packet
	 * buffers can be locked in memory (doesn't go to secondary memory due to paging)
	 */
	if (setrlimit(RLIMIT_MEMLOCK, &rlim)) {
		fprintf(stderr, "ERROR: setrlimit(RLIMIT_MEMLOCK) \"%s\"\n",
			strerror(errno));
		exit(EXIT_FAILURE);
	}

	/* Allocate memory for NUM_FRAMES of the default XDP frame size */
	packet_buffer_size = NUM_FRAMES * FRAME_SIZE;

	for(int i = 0; i < MAX_NUMBER_CORES; i++) {
		if (posix_memalign(&packet_buffer[i],
				getpagesize(), /* PAGE_SIZE aligned */
				packet_buffer_size)) {
			fprintf(stderr, "ERROR: Can't allocate buffer memory \"%s\"\n",
				strerror(errno));
			exit(EXIT_FAILURE);
		}

		/* Initializes the memory buffer allocated above to 
		* use it for the AF_XDP UMEM.
		*/
		umem[i] = configure_xsk_umem(packet_buffer[i], packet_buffer_size);
		if (umem[i] == NULL) {
			fprintf(stderr, "ERROR: Can't create umem \"%s\"\n",
				strerror(errno));
			exit(EXIT_FAILURE);
		}

		/* Open and configure the AF_XDP (xsk) socket */
		cfg.xsk_if_queue = i;
		xsk_socket[i] = xsk_configure_socket(&cfg, umem[i]);
		xsk_socket[i]->cpu_id = i;
		if (xsk_socket[i] == NULL) {
			fprintf(stderr, "ERROR: Can't setup AF_XDP socket \"%s\"\n",
				strerror(errno));
			exit(EXIT_FAILURE);
		}

		/* Start thread to do statistics display */
		/*if (verbose) {
			ret = pthread_create(&stats_poll_thread[i], NULL, stats_poll,
						xsk_socket[i]);
			if (ret) {
				fprintf(stderr, "ERROR: Failed creating statistics thread "
					"\"%s\"\n", strerror(errno));
				exit(EXIT_FAILURE);
			}
		}*/
	}

	for(int i = 0; i < MAX_NUMBER_CORES; i++) {
		if (pthread_mutex_init(&worker_lock[i], NULL) != 0) {
        	printf("Lock initialization failed\n");
        	return 1;
    	}
	}

	int maps_fd[4];
	int tail_app_map_fd, context_fd, f_info_fd;
	if(!get_all_map_fd(maps_fd, &tail_app_map_fd, &context_fd, &f_info_fd))
		exit(EXIT_FAIL_BPF);

	pthread_t threads[MAX_NUMBER_CORES];
	cpu_set_t cpuset;
	CPU_ZERO(&cpuset);
	for(int i = 0; i < MAX_NUMBER_CORES; i++) {
		struct worker_argument *arg = malloc(sizeof(struct worker_argument));
		arg->cfg = &cfg;
		arg->xsk_socket = xsk_socket[i];
		arg->prod_map_fd = maps_fd[0];
		arg->tail_map_fd = tail_app_map_fd;
		CPU_SET(i, &cpuset);
		pthread_create(&threads[i], NULL, producer_and_afxdp, (void *) arg);
		pthread_setaffinity_np(threads[i], sizeof(cpu_set_t), &cpuset);
		CPU_ZERO(&cpuset);
	}

	if(!global_exit) {
		CPU_ZERO(&cpuset);
		for(int i = 0; i < MAX_NUMBER_CORES; i++) {
			struct idle_checker_argument *arg = malloc(sizeof(struct idle_checker_argument));
			arg->tail_map_fd = tail_app_map_fd;
			arg->flow_info_fd = f_info_fd;
			arg->xsk_socket = xsk_socket[i];
			CPU_SET(i, &cpuset);
			pthread_create(&threads[i], NULL, idle_checker, (void *) arg);
			pthread_setaffinity_np(threads[i], sizeof(cpu_set_t), &cpuset);
			CPU_ZERO(&cpuset);
		}
		distribute_requests(maps_fd, context_fd, f_info_fd, tail_app_map_fd);
	}

	for(int i = 0; i < MAX_NUMBER_CORES; i++) {
		pthread_join(threads[i], NULL);
		pthread_mutex_destroy(&worker_lock[i]);
		xsk_socket__delete(xsk_socket[i]->xsk);
		xsk_umem__delete(umem[i]->umem);
	}

	return EXIT_OK;
}