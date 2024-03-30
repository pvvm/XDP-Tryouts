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
#define BURST_SIZE 64

/* basicfwd.c: Basic DPDK skeleton forwarding example. */

/*
 * Initializes a given port using global settings and with the RX buffers
 * coming from the mbuf_pool passed as a parameter.
 */

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

/*
 * The lcore main. This is the main thread that does the work, reading from
 * an input port and writing to an output port.
 */

 /* Basic forwarding application lcore. 8< */
static __rte_noreturn void
lcore_main(void)
{
	uint16_t port;

	/*
	 * Check that the port is on the same NUMA node as the polling thread
	 * for best performance.
	 */
	RTE_ETH_FOREACH_DEV(port)
		if (rte_eth_dev_socket_id(port) >= 0 &&
				rte_eth_dev_socket_id(port) !=
						(int)rte_socket_id())
			printf("WARNING, port %u is on remote NUMA node to "
					"polling thread.\n\tPerformance will "
					"not be optimal.\n", port);

	printf("\nCore %u forwarding packets. [Ctrl+C to quit]\n",
			rte_lcore_id());

	/* Main work of application loop. 8< */
	for (;;) {
		/*
		 * Receive packets on a port and forward them on the paired
		 * port. The mapping is 0 -> 1, 1 -> 0, 2 -> 3, 3 -> 2, etc.
		 */
		RTE_ETH_FOREACH_DEV(port) {

			/* Get burst of RX packets, from first port of pair. */
			struct rte_mbuf *bufs[BURST_SIZE];
			const uint16_t nb_rx = rte_eth_rx_burst(port, 0,
					bufs, BURST_SIZE);

			if (unlikely(nb_rx == 0))
				continue;

			/* Send burst of TX packets, to second port of pair. */
			const uint16_t nb_tx = rte_eth_tx_burst(port ^ 1, 0,
					bufs, nb_rx);

			/* Free any unsent packets. */
			if (unlikely(nb_tx < nb_rx)) {
				uint16_t buf;
				for (buf = nb_tx; buf < nb_rx; buf++)
					rte_pktmbuf_free(bufs[buf]);
			}
		}
	}
	/* >8 End of loop. */
}

void test_rx(int port) {
	for(;;) {
		rte_delay_us_sleep(1000000);
		struct rte_mbuf *bufs[BURST_SIZE];
               	const uint16_t nb_rx = rte_eth_rx_burst(port, 0,
               		bufs, BURST_SIZE);
		printf("%d\n", nb_rx);
	}
}

void fill_tcp_packet(struct rte_mbuf *pkt, const void *data, int port_id, int src_port) {
	if(rte_pktmbuf_tailroom(pkt) < strlen(data)) {
		printf("Not enough space in packet buffer\n");
		return;
	}

	/*		Ethernet header section			*/
	// rte_pktmbuf_mtod is a macro that returns the pointer at start of packet, while casting to ether_hdr
	struct rte_ether_hdr *eth_hdr = rte_pktmbuf_mtod(pkt, struct rte_ether_hdr *);
	struct rte_ipv4_hdr *ip_hdr = (struct rte_ipv4_hdr *)((uint8_t *)eth_hdr + sizeof(struct rte_ether_hdr));
	struct rte_tcp_hdr *tcp_hdr = (struct rte_tcp_hdr *) ((uint8_t *)ip_hdr + sizeof(struct rte_ipv4_hdr));
	uint8_t *data_pointer = (uint8_t *) tcp_hdr + sizeof(struct rte_tcp_hdr);
	// Retrives MAC address of the Ethernet Device to place it in s_addr
	rte_eth_macaddr_get(port_id, &eth_hdr->src_addr);
	// With the destination address in string format, we convert to an ether_addr and we copy it to d_addr
	const char *dest_mac = "e4:1d:2d:13:9e:c0";
	struct rte_ether_addr mac_addr;
	if(rte_ether_unformat_addr(dest_mac, &mac_addr) < 0) {
		printf("Incorrect destination address format");
		return;
	}
	rte_ether_addr_copy(&mac_addr, &eth_hdr->dst_addr);
	// Converts a 16-bit value from CPU order to big endian
	eth_hdr->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);


	/*		IP header section			*/
	// Converts a 32-bit value from CPU order to big endian, placing it as the source and destination IP address
	ip_hdr->src_addr = rte_cpu_to_be_32(RTE_IPV4(10, 7, 0, 7));
	ip_hdr->dst_addr = rte_cpu_to_be_32(RTE_IPV4(10, 7, 0, 6));
	// Places the type of the next header (TCP)
	ip_hdr->next_proto_id = IPPROTO_TCP;

	/*		TCP header section			*/
	tcp_hdr->src_port = rte_cpu_to_be_16(src_port);
	tcp_hdr->dst_port = rte_cpu_to_be_16(123);

	//printf("%lu %lu %lu %lu\n", strlen(data), sizeof(struct rte_eth_hdr *), sizeof(struct rte_ipv4_hdr *), sizeof(struct rte_tcp_hdr *));

	// Copies the data into where the pointer tells, with a given number of bytes
	rte_memcpy(data_pointer, data, strlen(data));
}

void packet_gen(uint16_t port_id) {

	// Structure that represents the TX buffer
	struct rte_eth_dev_tx_buffer *tx_buffer;

	// Allocates TX buffer in memory, with size defined by a macro and NUMA socket to allocate memory on
	tx_buffer = rte_zmalloc_socket("tx_buffer", RTE_ETH_TX_BUFFER_SIZE(BURST_SIZE), 0, rte_eth_dev_socket_id(port_id));

	if(tx_buffer == NULL) {
		printf("Failed to allocate TX buffer\n");
		return;
	}

	int ret = rte_eth_tx_buffer_init(tx_buffer, BURST_SIZE);
	if(ret < 0) {
		printf("Failed to initialize TX buffer");
		return;
	}


	// Creates memory buffer that stores packets while processing them, which number of elements according to TX queue and default mbuf size
	struct rte_mempool *mbuf_pool = rte_pktmbuf_pool_create("mbuf_pool", TX_RING_SIZE, 0, 0, RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());

	if(mbuf_pool == NULL) {
		printf("Failed to create membuf pool\n");
	}


	const char *data = "testing";
	/*struct rte_mbuf *bufs[BURST_SIZE];
        for(int i = 0; i < BURST_SIZE; i++) {
                bufs[i] = rte_pktmbuf_alloc(mbuf_pool);
                fill_tcp_packet(bufs[i], data, port_id, 1);
        }*/

	for (int i = 0; i < 100; i++) {
		struct rte_mbuf *bufs[BURST_SIZE];
        	for(int j = 0; j < BURST_SIZE; j++) {
                	bufs[j] = rte_pktmbuf_alloc(mbuf_pool);
                	fill_tcp_packet(bufs[j], data, port_id, 1);
       		}
		printf("Teste");
                /* Get burst of RX packets, from first port of pair. */
                const uint16_t nb_tx = rte_eth_tx_burst(port_id, 0,
                                bufs, BURST_SIZE);

                printf("%d\n", nb_tx);
		for(int j = 0; j < BURST_SIZE; j++) {
			rte_pktmbuf_free(bufs[j]);
		}
        }


	/*const char *data = "testing";
	int core_count = rte_lcore_count();
	for(int i = 0; i < 100; i++) {
		for(int lcore_id = 0; lcore_id < core_count; lcore_id++) {
			if(rte_lcore_is_enabled(lcore_id)) {
				for(int j = 0; j < BURST_SIZE; j++) {
					struct rte_mbuf *pkt = rte_pktmbuf_alloc(mbuf_pool);
					printf("Alocou pacote\n");
					if(pkt == NULL) {
						printf("Failed to allocate membuf to a packet");
						return;
					}

					fill_tcp_packet(pkt, data, port_id, 1);
					printf("Encheu pacote\n");
					// Buffer a packet for future transmission on a port (port_id) and TX queue (0)
					// tx_buffer is the buffer that collects the packets, and pkt is the pointer to the packet in mbuf to be sent
					printf("%d\n", rte_eth_tx_buffer(port_id, 0, tx_buffer, pkt));// {
					//	printf("Could not enqueue the packet to TX buffer");
					//	return;
					//}
					//printf("Passou pacote pra tx buffer\n");
					//if(j == 31)
					//	printf("Pacotes mandados: %d\n", rte_eth_tx_buffer_flush(port_id, 0, tx_buffer));
				}
				printf("Pacotes mandados: %d\n", rte_eth_tx_buffer_flush(port_id, 0, tx_buffer));
			}
			printf("lcore_id = %d\n", lcore_id);
		}
		printf("i = %d\n", i);
	}*/

	rte_free(tx_buffer);
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

	//if (rte_lcore_count() > 1)
	//	printf("\nWARNING: Too many lcores enabled. Only 1 used.\n");
	//printf("\n%u\n", portid);

	/* Call lcore_main on the main core only. Called on single lcore. 8< */
	//lcore_main();
	/* >8 End of called on single lcore. */

	//packet_gen(portid);
	test_rx(portid);

	if(rte_eth_dev_stop(portid))
		printf("Failed while stopping device %d\n", portid);

	if(rte_eth_dev_close(portid))
		printf("Failed while closing device %d\n", portid);

	/* clean up the EAL */
	rte_eal_cleanup();

	return 0;
}
