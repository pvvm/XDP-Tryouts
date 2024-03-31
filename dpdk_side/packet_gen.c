/* SPDX-License-Identifier: BSD-3-Clause
 * Copyright(c) 2010-2015 Intel Corporation
 */

#include <stdint.h>
#include <stdlib.h>
#include <inttypes.h>
#include <rte_eal.h>
#include <rte_ethdev.h>
#include <rte_cycles.h>
#include <rte_lcore.h>
#include <rte_mbuf.h>
#include <rte_malloc.h>

#include <rte_ether.h>
#include <rte_ip.h>
#include <rte_tcp.h>

#define RX_RING_SIZE 1024
#define TX_RING_SIZE 1024

#define NUM_MBUFS 8191
#define MBUF_CACHE_SIZE 250
#define BURST_SIZE 32

#define TOTAL_RCV_CPU 8
#define SRC_PORT_LIST {1, 17, 25, 9, 8, 24, 16, 3}

/* basicfwd.c: Basic DPDK skeleton forwarding example. */

/*
 * Initializes a given port using global settings and with the RX buffers
 * coming from the mbuf_pool passed as a parameter.
 */

// Based on https://github.com/thewhoo/dpdk-tcp-generator/blob/master/conn.c#L103

/* Main functional part of port initialization. 8< */
static inline int
port_init(uint16_t port, struct rte_mempool *mbuf_pool)
{
	struct rte_eth_conf port_conf;
	const uint16_t rx_rings = 1, tx_rings = 1;
	uint16_t nb_rxd = RX_RING_SIZE;
	uint16_t nb_txd = TX_RING_SIZE;
	int retval;
	uint16_t q;
	struct rte_eth_dev_info dev_info;
	struct rte_eth_txconf txconf;

	if (!rte_eth_dev_is_valid_port(port))
		return -1;

	//printf("Test 1 Port id %d\n", port);

	memset(&port_conf, 0, sizeof(struct rte_eth_conf));

	retval = rte_eth_dev_info_get(port, &dev_info);
	if (retval != 0) {
		printf("Error during getting device (port %u) info: %s\n",
				port, strerror(-retval));
		return retval;
	}

	//printf("Test 2");

	if (dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
		port_conf.txmode.offloads |=
			RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;

	//printf("Test 3");
	/* Configure the Ethernet device. */
	retval = rte_eth_dev_configure(port, rx_rings, tx_rings, &port_conf);
	if (retval != 0)
		return retval;

	//printf("Test 4");
	retval = rte_eth_dev_adjust_nb_rx_tx_desc(port, &nb_rxd, &nb_txd);
	if (retval != 0)
		return retval;

	//printf("Test 5");
	/* Allocate and set up 1 RX queue per Ethernet port. */
	for (q = 0; q < rx_rings; q++) {
		retval = rte_eth_rx_queue_setup(port, q, nb_rxd,
				rte_eth_dev_socket_id(port), NULL, mbuf_pool);
		if (retval < 0)
			return retval;
	}
	//printf("Test 6");
	txconf = dev_info.default_txconf;
	txconf.offloads = port_conf.txmode.offloads;
	/* Allocate and set up 1 TX queue per Ethernet port. */
	for (q = 0; q < tx_rings; q++) {
		retval = rte_eth_tx_queue_setup(port, q, nb_txd,
				rte_eth_dev_socket_id(port), &txconf);
		if (retval < 0)
			return retval;
	}
	//printf("Test 7");
	/* Starting Ethernet port. 8< */
	retval = rte_eth_dev_start(port);
	//printf("\nretval %d\n", retval);
	/* >8 End of starting of ethernet port. */
	if (retval < 0)
		return retval;

	//printf("Test 8");
	/* Display the port MAC address. */
	struct rte_ether_addr addr;
	retval = rte_eth_macaddr_get(port, &addr);
	if (retval != 0)
		return retval;

	printf("Port %u MAC: %02" PRIx8 " %02" PRIx8 " %02" PRIx8
			   " %02" PRIx8 " %02" PRIx8 " %02" PRIx8 "\n",
			port, RTE_ETHER_ADDR_BYTES(&addr));

	/* Enable RX in promiscuous mode for the Ethernet device. */
	retval = rte_eth_promiscuous_enable(port);
	/* End of setting RX port in promiscuous mode. */
	if (retval != 0)
		return retval;
	return 0;
}
/* >8 End of main functional part of port initialization. */

void test_rx(int port) {
	for(;;) {
		rte_delay_us_sleep(1000000);
		struct rte_mbuf *bufs[BURST_SIZE];
               	const uint16_t nb_rx = rte_eth_rx_burst(port, 0,
               		bufs, BURST_SIZE);
		printf("%d\n", nb_rx);
	}
}

void fill_eth_header(struct rte_ether_hdr *eth, int port_id) {
	// Retrives MAC address of the Ethernet Device to be the source addr
        rte_eth_macaddr_get(port_id, &eth->src_addr);

	// With the destination address in string format, we convert to an ether_addr and we copy it to d_addr
        const char *dest_mac = "e4:1d:2d:13:9e:c0";
        struct rte_ether_addr mac_addr;
        if(rte_ether_unformat_addr(dest_mac, &mac_addr) < 0) {
                printf("Incorrect destination address format\n");
                return;
        }
        rte_ether_addr_copy(&mac_addr, &eth->dst_addr);

	eth->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
}

void fill_ip_header(struct rte_ipv4_hdr *ip, uint16_t length) {
	ip->version_ihl = 0x45;
	ip->type_of_service = 0;
	ip->total_length = rte_cpu_to_be_16(length);
	ip->packet_id = 0;
	ip->fragment_offset = rte_cpu_to_be_16(0x4000);
	ip->time_to_live = 64;
	ip->next_proto_id = IPPROTO_TCP;
	ip->hdr_checksum = 0;
	ip->src_addr = rte_cpu_to_be_32(RTE_IPV4(10, 7, 0, 7));
	ip->dst_addr = rte_cpu_to_be_32(RTE_IPV4(10, 7, 0, 6));
	ip->hdr_checksum = rte_ipv4_cksum(ip);
}

void fill_tcp_header(struct rte_tcp_hdr *tcp, int source_port, struct rte_ipv4_hdr *ip) {
	tcp->src_port = rte_cpu_to_be_16(source_port);
	tcp->dst_port = rte_cpu_to_be_16(123);
	tcp->sent_seq = 0;
	tcp->recv_ack = 0;
	tcp->data_off = 0x50;
	tcp->tcp_flags = 0x02;
	tcp->rx_win = rte_cpu_to_be_16(0xfaf0);
	tcp->tcp_urp = 0;
    tcp->cksum = 0;
    tcp->cksum = rte_ipv4_udptcp_cksum(ip, tcp);
}

int send_tcp_packet(int port_id, int number_rcv_cpus, struct rte_mempool *mbuf_pool) {

	int src_port_list[TOTAL_RCV_CPU] = SRC_PORT_LIST;
	int src_port;

	struct rte_mbuf *pkt[BURST_SIZE];

	for(int i = 0; i < BURST_SIZE; i++) {
		pkt[i] = rte_pktmbuf_alloc(mbuf_pool);
		if(pkt[i] == NULL) {
			printf("Failed to allocate memory buffer for packet\n");
			return -1;
		}

		int total_header_len = sizeof(struct rte_ether_hdr) + sizeof(struct rte_ipv4_hdr) + sizeof(struct rte_tcp_hdr);
		pkt[i]->pkt_len = total_header_len;
		pkt[i]->data_len = total_header_len;

		struct rte_ether_hdr *eth_hdr = rte_pktmbuf_mtod(pkt[i], struct rte_ether_hdr *);
		struct rte_ipv4_hdr *ip_hdr = rte_pktmbuf_mtod_offset(pkt[i], struct rte_ipv4_hdr *, sizeof(struct rte_ether_hdr));
		struct rte_tcp_hdr *tcp_hdr = rte_pktmbuf_mtod_offset(pkt[i], struct rte_tcp_hdr *, sizeof(struct rte_ether_hdr) + sizeof(struct rte_ipv4_hdr));

		fill_eth_header(eth_hdr, port_id);

		fill_ip_header(ip_hdr, total_header_len - sizeof(struct rte_ether_hdr));

		src_port = src_port_list[i % number_rcv_cpus];
		//printf("%d\n", src_port_list[i % number_rcv_cpus]);

		fill_tcp_header(tcp_hdr, src_port, ip_hdr);
	}
	printf("Number of packets sent: %d\n", rte_eth_tx_burst(port_id, 0, pkt, BURST_SIZE));
}

void packet_gen(uint16_t port_id, struct rte_mempool *mbuf_pool) {
	int num_cpu;
	printf("Number of CPUs on the rcv side: ");
	if (scanf("%d", &num_cpu) > 0) {
		for (;;) {
			send_tcp_packet(port_id, num_cpu, mbuf_pool);
        	}
	}
}

/* >8 End Basic forwarding application lcore. */

/*
 * The main function, which does initialization and calls the per-lcore
 * functions.
 */
int
main(int argc, char *argv[])
{
	struct rte_mempool *mbuf_pool;
	unsigned nb_ports;
	uint16_t portid;

	/* Initializion the Environment Abstraction Layer (EAL). 8< */
	int ret = rte_eal_init(argc, argv);
	if (ret < 0)
		rte_exit(EXIT_FAILURE, "Error with EAL initialization\n");
	/* >8 End of initialization the Environment Abstraction Layer (EAL). */

	argc -= ret;
	argv += ret;

	/* Check that there is an even number of ports to send/receive on. */
	nb_ports = rte_eth_dev_count_avail();
	//printf("\n%d\n", nb_ports);

	/* Creates a new mempool in memory to hold the mbufs. */

	/* Allocates mempool to hold the mbufs. 8< */
	mbuf_pool = rte_pktmbuf_pool_create("MBUF_POOL", NUM_MBUFS * nb_ports,
		MBUF_CACHE_SIZE, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());
	/* >8 End of allocating mempool to hold mbuf. */

	if (mbuf_pool == NULL)
		rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n");

	/* Initializing all ports. 8< */
	//RTE_ETH_FOREACH_DEV(portid)
	if (port_init(portid, mbuf_pool) != 0)
		rte_exit(EXIT_FAILURE, "Cannot init port %"PRIu16 "\n",
					portid);
	/* >8 End of initializing all ports. */

	packet_gen(portid, mbuf_pool);
	//test_rx(portid);

	if(rte_eth_dev_stop(portid))
		printf("Failed while stopping device %d\n", portid);

	if(rte_eth_dev_close(portid))
		printf("Failed while closing device %d\n", portid);

	/* clean up the EAL */
	rte_eal_cleanup();

	return 0;
}
