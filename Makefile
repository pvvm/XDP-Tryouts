# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)

# Departing from the implicit _user.c scheme
XDP_TARGETS  := xdp_prog_kern
USER_TARGETS := xdp_load_and_stats

COMMON_DIR = ../common

COMMON_OBJS += $(COMMON_DIR)/common_user_bpf_xdp.o
include $(COMMON_DIR)/common.mk
