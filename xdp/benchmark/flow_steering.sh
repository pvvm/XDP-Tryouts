#!/bin/bash

# Define the base command
BASE_COMMAND="sudo ethtool --config-ntuple enp59s0f1np1 flow-type tcp4 src-ip 10.7.0.7 dst-ip 10.7.0.6"

# Loop 20 times
for i in {0..19}; do
  SRC_PORT=$i
  ACTION=$i
  COMMAND="$BASE_COMMAND src-port $SRC_PORT dst-port 123 action $ACTION"
  echo "Executing: $COMMAND"
  $COMMAND
done