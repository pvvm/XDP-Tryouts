#ifndef CREATE_PACKET_H
#define CREATE_PACKET_H

#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>

void create_eth_header(struct ethhdr *eth_hdr) {
    memset(eth_hdr, 0, sizeof(struct ethhdr));
    eth_hdr->h_proto = htons(ETH_P_IP);  // IP Ethertype
    unsigned char src_mac[ETH_ALEN] = {0xE4, 0x1D, 0x2D, 0x13, 0x9E, 0xD0}; // Example: Specific MAC address
    memcpy(eth_hdr->h_source, src_mac, ETH_ALEN);
    unsigned char dest_mac[ETH_ALEN] = {0xF4, 0x52, 0x14, 0x5A, 0x90, 0x70};
    memcpy(eth_hdr->h_dest, dest_mac, ETH_ALEN);
}

void create_ip_header(struct iphdr *ip_hdr) {
    memset(ip_hdr, 0, sizeof(struct iphdr));
    ip_hdr->version = 4;
    ip_hdr->ihl = 5;
    ip_hdr->tot_len = htons(sizeof(struct iphdr) + sizeof(struct tcphdr));  // Adjust if more data is added
    ip_hdr->protocol = IPPROTO_TCP;
    ip_hdr->saddr = inet_addr("10.7.0.7");
    ip_hdr->daddr = inet_addr("10.7.0.8");
}

void create_tcp_header(struct tcphdr *tcp_hdr) {
	memset(tcp_hdr, 0, sizeof(struct tcphdr));
	tcp_hdr->source = htonl(1);
	tcp_hdr->dest = htonl(123);
	//tcp_hdr->seq = htonl(0);
	//tcp_hdr->ack_seq = htonl(0);
}

void create_packet(unsigned char *data, size_t *data_len) {
    struct ethhdr eth_hdr;
    struct iphdr ip_hdr;
    struct tcphdr tcp_hdr;
    
    create_eth_header(&eth_hdr);
    create_ip_header(&ip_hdr);
    create_tcp_header(&tcp_hdr);

    size_t offset = 0;
    memcpy(data + offset, &eth_hdr, sizeof(eth_hdr));
    offset += sizeof(eth_hdr);
    memcpy(data + offset, &ip_hdr, sizeof(ip_hdr));
    offset += sizeof(ip_hdr);
    memcpy(data + offset, &tcp_hdr, sizeof(tcp_hdr));
    offset += sizeof(tcp_hdr);

    *data_len = offset;
}

#endif