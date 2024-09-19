#ifndef CREATE_PACKET_H
#define CREATE_PACKET_H

#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/udp.h>
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
    __u32 data_len;
    __u32 hdr_combination;
	struct BTHeader bth;
	struct RETHeader reth;
	struct AETHeader aeth;
};

void create_eth_header(struct ethhdr *eth_hdr,  __u8 src_mac[], __u8 dst_mac[]) {
    memset(eth_hdr, 0, sizeof(struct ethhdr));
    eth_hdr->h_proto = htons(ETH_P_IP);  // IP Ethertype
    memcpy(eth_hdr->h_source, src_mac, ETH_ALEN);
    memcpy(eth_hdr->h_dest, dst_mac, ETH_ALEN);
}

void create_ip_header(struct iphdr *ip_hdr, __be32 src_ip, __be32 dst_ip, int *ip_id, __u32 data_len) {
    memset(ip_hdr, 0, sizeof(struct iphdr));
    ip_hdr->version = 4;
    ip_hdr->ihl = 5;
    ip_hdr->tot_len = htons(data_len + sizeof(struct iphdr) + sizeof(struct tcphdr));  // Adjust if more data is added
    ip_hdr->protocol = IPPROTO_TCP;
    //ip_hdr->saddr = inet_addr("10.7.0.7");
    //ip_hdr->daddr = inet_addr("10.7.0.8");
    ip_hdr->saddr = src_ip;
    ip_hdr->daddr = dst_ip;
    if(ip_id)
        ip_hdr->id = *ip_id;
    else
        ip_hdr->id = 0;
}

/*void create_tcp_header(struct tcphdr *tcp_hdr, struct pkt_info p_info) {
	memset(tcp_hdr, 0, sizeof(struct tcphdr));
	//tcp_hdr->source = htonl(1);
	//tcp_hdr->dest = htonl(123);
    tcp_hdr->source = p_info.src_port;
    tcp_hdr->dest = p_info.dst_port;
	tcp_hdr->seq = htonl(p_info.seq);
	tcp_hdr->ack_seq = htonl(p_info.ack_seq);
    tcp_hdr->ack = p_info.ack_flag;
    tcp_hdr->window = htons(p_info.wnd_size);
    tcp_hdr->doff = 5;
}*/

void create_udp_header(struct udphdr *udp_hdr, __be16 src_port, __be16 dst_port, __be16 udp_len) {
    udp_hdr->source = htons(src_port);
    udp_hdr->dest = htons(dst_port);
    udp_hdr->len = udp_len;
}

void create_packet(unsigned char *data, size_t *data_len, struct pkt_info p_info, int *ip_id, char *data_buffer, int udp_length) {
    struct ethhdr eth_hdr;
    struct iphdr ip_hdr;
    //struct tcphdr tcp_hdr;
    struct udphdr udp_hdr;
    create_eth_header(&eth_hdr, p_info.src_mac, p_info.dst_mac);
    create_ip_header(&ip_hdr, p_info.src_ip, p_info.dst_ip, ip_id, p_info.data_len);

    if(udp_length == 0) {
        // In case it is a bpf_prog_run packet, set some predefined values
        udp_length = sizeof(struct udphdr) + sizeof(struct BTHeader);
        p_info.bth.opcode = 123;
    }
    create_udp_header(&udp_hdr, p_info.src_port, p_info.dst_port, udp_length);

    size_t offset = 0;
    memcpy(data + offset, &eth_hdr, sizeof(eth_hdr));
    offset += sizeof(eth_hdr);
    memcpy(data + offset, &ip_hdr, sizeof(ip_hdr));
    offset += sizeof(ip_hdr);
    memcpy(data + offset, &udp_hdr, sizeof(udp_hdr));
    offset += sizeof(udp_hdr);
    memcpy(data + offset, &(p_info.bth), sizeof(p_info.bth));
    offset += sizeof(p_info.bth);
    if(p_info.hdr_combination == 0) { // RETH
        //printf("OIE");
        memcpy(data + offset, &(p_info.reth), sizeof(p_info.reth));
        offset += sizeof(p_info.reth);
    } else if(p_info.hdr_combination == 2) { // AETH
        //printf("OLA");
        memcpy(data + offset, &(p_info.aeth), sizeof(p_info.aeth));
        offset += sizeof(p_info.aeth);
    }/* else if(p_info.hdr_combination == 1)
        printf("HELLO");*/

    if(data_buffer && p_info.data_len > 0) {
        //printf("HERE:\n%s\n", data_buffer);
        memcpy(data + offset, data_buffer, p_info.data_len);
        offset += p_info.data_len;
    }

    *data_len += offset;
}

struct pkt_info set_pkt_info(struct metadata_hdr meta_hdr, struct net_metadata meta_net) {
    struct pkt_info info;

    memcpy(info.src_mac, meta_hdr.dst_mac, ETH_ALEN);
    memcpy(info.dst_mac, meta_hdr.src_mac, ETH_ALEN);

    info.src_ip = meta_hdr.dst_ip;
    info.dst_ip = meta_hdr.src_ip;

    info.src_port = meta_hdr.dst_port;
    info.dst_port = meta_hdr.src_port;

    /*info.ack_flag = meta_net.ack_flag;
    info.ack_seq = meta_net.ack_num;
    info.seq = meta_net.seq_num;
    info.wnd_size = meta_net.wnd_size;*/
    info.data_len = meta_net.length;
    info.aeth = meta_net.aeth;
    info.reth = meta_net.reth;
    info.bth = meta_net.bth;
    info.hdr_combination = meta_net.hdr_combination;

    /*memcpy(&tmp_ip, &meta_hdr->dst_ip, sizeof(tmp_ip));
    memcpy(&meta_hdr->dst_ip, &meta_hdr->src_ip, sizeof(tmp_ip));
    memcpy(&meta_hdr->src_ip, &tmp_ip, sizeof(tmp_ip));*/

    return info;
}

/* This is a temporary function, that will be used temporarily to set 
default values to headers*/
struct pkt_info temporary_default_info_send(int i) {
    struct pkt_info info;

    unsigned char src_mac[ETH_ALEN] = {0x08, 0xC0, 0xEB, 0x96, 0x85, 0x85};
    memcpy(info.src_mac, src_mac, ETH_ALEN);
    unsigned char dst_mac[ETH_ALEN] = {0xE8, 0xEB, 0xD3, 0xA4, 0x89, 0x8B};
    memcpy(info.dst_mac, dst_mac, ETH_ALEN);

    info.src_ip = inet_addr("192.168.4.231");
    info.dst_ip = inet_addr("192.168.4.244");

    info.src_port = htons(i);
    info.dst_port = htons(i);

    return info;
}

struct pkt_info temporary_default_info_rcv(int i) {
    struct pkt_info info;

    unsigned char src_mac[ETH_ALEN] = {0xE8, 0xEB, 0xD3, 0xA4, 0x89, 0x8B};
    memcpy(info.src_mac, src_mac, ETH_ALEN);
    unsigned char dst_mac[ETH_ALEN] = {0x08, 0xC0, 0xEB, 0x96, 0x85, 0x85};
    memcpy(info.dst_mac, dst_mac, ETH_ALEN);

    info.src_ip = inet_addr("192.168.4.244");
    info.dst_ip = inet_addr("192.168.4.231");

    info.src_port = htons(i);
    info.dst_port = htons(i);

    info.hdr_combination = 999;

    return info;
}

struct flow_id convert_pktinfo_to_flow_id(struct pkt_info p_info) {
    struct flow_id f_id;
    f_id.src_ip = p_info.src_ip; 
    f_id.dest_ip = p_info.dst_ip;
    f_id.src_port = ntohs(p_info.src_port);
    f_id.dest_port = ntohs(p_info.dst_port);

    return f_id;
}

#endif

