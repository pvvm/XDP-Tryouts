#ifndef CREATE_PACKET_H
#define CREATE_PACKET_H

#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <arpa/inet.h>
#include "common_def.h"

struct pkt_info {
    __u8 src_mac[ETH_ALEN];
    __u8 dst_mac[ETH_ALEN];
    __be32 src_ip;
    __be32 dst_ip;
    __be16 src_port;
    __be16 dst_port;
};

void create_eth_header(struct ethhdr *eth_hdr,  __u8 src_mac[], __u8 dst_mac[]) {
    memset(eth_hdr, 0, sizeof(struct ethhdr));
    eth_hdr->h_proto = htons(ETH_P_IP);  // IP Ethertype
    memcpy(eth_hdr->h_source, src_mac, ETH_ALEN);
    memcpy(eth_hdr->h_dest, dst_mac, ETH_ALEN);
}

void create_ip_header(struct iphdr *ip_hdr, __be32 src_ip, __be32 dst_ip, int *ip_id) {
    memset(ip_hdr, 0, sizeof(struct iphdr));
    ip_hdr->version = 4;
    ip_hdr->ihl = 5;
    ip_hdr->tot_len = htons(sizeof(struct iphdr) + sizeof(struct tcphdr));  // Adjust if more data is added
    ip_hdr->protocol = IPPROTO_TCP;
    //ip_hdr->saddr = inet_addr("10.7.0.7");
    //ip_hdr->daddr = inet_addr("10.7.0.8");
    ip_hdr->saddr = src_ip;
    ip_hdr->daddr = dst_ip;
    if(ip_id)
        ip_hdr->id = *ip_id;
}

void create_tcp_header(struct tcphdr *tcp_hdr, __be16 src_port, __be16 dst_port) {
	memset(tcp_hdr, 0, sizeof(struct tcphdr));
	//tcp_hdr->source = htonl(1);
	//tcp_hdr->dest = htonl(123);
    tcp_hdr->source = src_port;
    tcp_hdr->dest = dst_port;
	//tcp_hdr->seq = htonl(0);
	//tcp_hdr->ack_seq = htonl(0);
    tcp_hdr->doff = 5;
}

void create_packet(unsigned char *data, size_t *data_len, struct pkt_info p_info, int *ip_id) {
    struct ethhdr eth_hdr;
    struct iphdr ip_hdr;
    struct tcphdr tcp_hdr;
    create_eth_header(&eth_hdr, p_info.src_mac, p_info.dst_mac);
    create_ip_header(&ip_hdr, p_info.src_ip, p_info.dst_ip, ip_id);
    create_tcp_header(&tcp_hdr, p_info.src_port, p_info.dst_port);

    size_t offset = 0;
    memcpy(data + offset, &eth_hdr, sizeof(eth_hdr));
    offset += sizeof(eth_hdr);
    memcpy(data + offset, &ip_hdr, sizeof(ip_hdr));
    offset += sizeof(ip_hdr);
    memcpy(data + offset, &tcp_hdr, sizeof(tcp_hdr));
    offset += sizeof(tcp_hdr);

    *data_len = offset;
}

struct pkt_info set_pkt_info(struct metadata_hdr meta_hdr, struct net_metadata meta_net) {
    struct pkt_info info;

    memcpy(info.src_mac, meta_hdr.dst_mac, ETH_ALEN);
    memcpy(info.dst_mac, meta_hdr.src_mac, ETH_ALEN);

    info.src_ip = meta_hdr.dst_ip;
    info.dst_ip = meta_hdr.src_ip;

    info.src_port = meta_hdr.dst_port;
    info.dst_port = meta_hdr.src_port;

    /*memcpy(&tmp_ip, &meta_hdr->dst_ip, sizeof(tmp_ip));
    memcpy(&meta_hdr->dst_ip, &meta_hdr->src_ip, sizeof(tmp_ip));
    memcpy(&meta_hdr->src_ip, &tmp_ip, sizeof(tmp_ip));*/

    return info;
}

/* This is a temporary function, that will be used temporarily to set 
default values to headers*/
struct pkt_info temporary_default_info_send() {
    struct pkt_info info;

    unsigned char src_mac[ETH_ALEN] = {0xE4, 0x1D, 0x2D, 0x13, 0x9E, 0xD0};
    memcpy(info.src_mac, src_mac, ETH_ALEN);
    unsigned char dst_mac[ETH_ALEN] = {0xF4, 0x52, 0x14, 0x5A, 0x90, 0x70};
    memcpy(info.dst_mac, dst_mac, ETH_ALEN);

    info.src_ip = inet_addr("10.7.0.7");
    info.dst_ip = inet_addr("10.7.0.8");

    info.src_port = htons(230);
    info.dst_port = htons(3);

    return info;
}

struct pkt_info temporary_default_info_rcv() {
    struct pkt_info info;

    unsigned char src_mac[ETH_ALEN] = {0xF4, 0x52, 0x14, 0x5A, 0x90, 0x70};
    memcpy(info.src_mac, src_mac, ETH_ALEN);
    unsigned char dst_mac[ETH_ALEN] = {0xE4, 0x1D, 0x2D, 0x13, 0x9E, 0xD0};
    memcpy(info.dst_mac, dst_mac, ETH_ALEN);

    info.src_ip = inet_addr("10.7.0.8");
    info.dst_ip = inet_addr("10.7.0.7");

    info.src_port = htons(3);
    info.dst_port = htons(230);

    return info;
}

struct flow_id convert_pktinfo_to_flow_id(struct pkt_info p_info) {
    struct flow_id f_id;

    //__be32 saddr = p_info.dst_ip; 
    __be32 saddr = p_info.src_ip; 
    __u8 src_ip;
    src_ip = saddr & 0xFF;
    src_ip = ((saddr >> 8) & 0xFF) ^ src_ip;
    src_ip = ((saddr >> 16) & 0xFF) ^ src_ip;
    src_ip = ((saddr >> 24) & 0xFF) ^ src_ip;
	f_id.src_ip = src_ip;

	//__be32 daddr = p_info.src_ip;
    __be32 daddr = p_info.dst_ip;
    __u8 dst_ip;
    dst_ip = daddr & 0xFF;
    dst_ip = ((daddr >> 8) & 0xFF) ^ dst_ip;
    dst_ip = ((daddr >> 16) & 0xFF) ^ dst_ip;
    dst_ip = ((daddr >> 24) & 0xFF) ^ dst_ip;
	f_id.dest_ip = dst_ip;

	//__be16 sport = ntohs(p_info.dst_port);
    __be16 sport = ntohs(p_info.src_port);
	__u8 src_port;
    src_port = sport & 0xFF;
    src_port = ((sport >> 8) & 0xFF) ^ src_port;
	f_id.src_port = src_port;

	//__be16 dport = ntohs(p_info.src_port);
    __be16 dport = ntohs(p_info.dst_port);
	__u8 dst_port;
    dst_port = dport & 0xFF;
    dst_port = ((dport >> 8) & 0xFF) ^ dst_port;
	f_id.dest_port = dst_port;

    return f_id;
}

#endif