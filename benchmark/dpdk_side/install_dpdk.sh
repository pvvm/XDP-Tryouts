#!/bin/bash

# Update package repositories
sudo apt update

# Install dependencies
sudo apt install -y build-essential linux-headers-$(uname -r) wget

sudo pip3 install meson ninja

sudo apt install python3-pyelftools

# Download DPDK source code (adjust version as needed)
DPDK_VERSION="23.11"
wget http://fast.dpdk.org/rel/dpdk-${DPDK_VERSION}.tar.xz

# Extract DPDK source code
sudo tar -xf dpdk-${DPDK_VERSION}.tar.xz -C /opt
cd /opt/dpdk-${DPDK_VERSION}

# Set DPDK environment variables
export RTE_SDK=$(pwd)
export RTE_TARGET=x86_64-native-linuxapp-gcc

# Build DPDK
sudo meson build
sudo ninja -C build

cd build
sudo ninja install
sudo ldconfig

# Bind network interfaces to DPDK drivers (adjust as needed)
cd ../usertools
sudo modprobe -a ib_uverbs mlx4_en mlx4_core mlx4_ib


# Setup hugepages
#PAGE_SIZE="2M"
#TOTAL_SIZE="1G"
PAGE_SIZE="1G"
TOTAL_SIZE="24G"

sudo dpdk-hugepages.py -p ${PAGE_SIZE} --setup ${TOTAL_SIZE}

# Verify DPDK installation
echo "DPDK has been installed successfully."

