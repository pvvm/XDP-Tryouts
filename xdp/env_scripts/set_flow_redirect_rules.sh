#!/bin/bash

# Read the input arguments
action=$1
rx_queues=$2
max_rules=${3:-1024}
port_mask=$4

# Set the interface name
interface="ens1f1np1"

# Define source and destination IPs for icelake1
src_ip_icelake1="192.168.4.244"
dst_ip_icelake1="192.168.4.231"

# Define source and destination IPs for icelake2 (inverted)
src_ip_icelake2="192.168.4.231"
dst_ip_icelake2="192.168.4.244"

# Function to set ntuple rules with RX queue redirection
set_rules() {
    local src_ip=$1
    local dst_ip=$2
    for port in $(seq 1 $max_rules); do
        # Calculate RX queue based on port number and rx_queues
        rx_queue=$(( (port - 1) % rx_queues ))
        
        # Configure ethtool rule with the calculated RX queue
        ethtool --config-ntuple $interface flow-type tcp4 \
            src-ip $src_ip dst-ip $dst_ip \
            src-port $port m $port_mask dst-port $port m $port_mask\
            action $rx_queue
    done
}

# Function to delete ntuple rules
delete_rules() {
    for port in $(seq 0 1023); do
        ethtool --config-ntuple $interface delete $port
    done
}

# Main script logic
if [ "$action" == "delete" ]; then
    delete_rules
elif [ "$action" == "icelake1" ]; then
    set_rules $src_ip_icelake1 $dst_ip_icelake1
elif [ "$action" == "icelake2" ]; then
    set_rules $src_ip_icelake2 $dst_ip_icelake2
else
    echo "Invalid argument. Use 'delete', 'icelake1', or 'icelake2'."
    exit 1
fi