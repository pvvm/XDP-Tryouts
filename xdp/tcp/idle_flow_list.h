#ifndef IDLE_FLOW_LIST_H
#define IDLE_FLOW_LIST_H

#include <time.h>
#include "req_queue.h"

struct idle_flow_info {
    __u32 f_id;
    struct pkt_info p_info;
    struct queue_flow_info q_flow_info;
    long last_time;
};

struct idle_flow_info idle_flow_array[MAX_NUMBER_CORES][MAX_NUMBER_FLOWS];

//struct app_req_info flow_info_array[MAX_NUMBER_CORES][MAX_NUMBER_FLOWS];
int num_idle_flow_array[MAX_NUMBER_CORES];

void init_idle_flow_array() {
    for(int i = 0; i < MAX_NUMBER_CORES; i++) {
        num_idle_flow_array[i] = 0;
    }
}

/*int cmp_flow_id(struct flow_id curr_f_id, struct flow_id new_f_id) {
    if(curr_f_id.src_ip == new_f_id.src_ip &&
    curr_f_id.dest_ip == new_f_id.dest_ip &&
    curr_f_id.src_port == new_f_id.src_port &&
    curr_f_id.dest_port == new_f_id.dest_port)
        return 1;
    return 0;
}*/

int find_idle_flow_info(int cpu_id, __u32 f_id) {
    int array_num = num_idle_flow_array[cpu_id];

    __u32 curr_f_id;
    for(int i = 0; i < array_num; i++) {
        curr_f_id = idle_flow_array[cpu_id][i].f_id;
        /*if(cmp_flow_id(curr_f_id, f_id)) {
            //printf("Flow already exists!\n");
            return 1;
        }*/
        if(curr_f_id == f_id) {
            printf("idle_flow_list: flow already exists\n");
            return 1;
        }
    }
    return 0;
}

void add_idle_flow_info(int cpu_id, struct pkt_info p_info, __u32 f_id, struct queue_flow_info f_info) {
    int array_num = num_idle_flow_array[cpu_id];
    //printf("%d", array_num);

    if(array_num >= MAX_NUMBER_FLOWS) {
        printf("Reached the limit of idle flow info for core %d\n", cpu_id);
        return;
    }
    //printf("f_info doesn't exist yet!\n");

    struct timespec curr_time;
    clock_gettime(CLOCK_MONOTONIC, &curr_time);

    idle_flow_array[cpu_id][array_num].f_id = f_id;
    idle_flow_array[cpu_id][array_num].p_info = p_info;
    idle_flow_array[cpu_id][array_num].q_flow_info = f_info;
    idle_flow_array[cpu_id][array_num].last_time = curr_time.tv_sec * 1000000000L + curr_time.tv_nsec;

    array_num++;
    num_idle_flow_array[cpu_id] = array_num;
}

int empty_queues(struct queue_flow_info f_info, __u32 app_queue_tail) {
    if(f_info.app_info.app_head != app_queue_tail ||
    f_info.timer_info.len_timer_queue != 0 ||
    f_info.prog_info.len_prog_queue != 0)
        return 0;
    return 1;
}

int cmp_queue_flow_info(struct queue_flow_info curr_f_info, struct queue_flow_info old_f_info) {
    /*printf("%d %d %d\n%d %d %d\n", curr_f_info.app_info.app_head, curr_f_info.timer_info.timer_head, 
    curr_f_info.prog_info.prog_head, old_f_info.app_info.app_head, old_f_info.timer_info.timer_head,
    old_f_info.prog_info.prog_head);*/
    if(curr_f_info.app_info.app_head == old_f_info.app_info.app_head &&
    curr_f_info.timer_info.timer_head == old_f_info.timer_info.timer_head &&
    curr_f_info.prog_info.prog_head == old_f_info.prog_info.prog_head)
        return 1;
    return 0;
}

#endif