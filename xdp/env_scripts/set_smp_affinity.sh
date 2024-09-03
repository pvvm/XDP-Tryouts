#!/bin/bash

# Read the input argument
server_name=$1

# Define function to set smp_affinity_list for a range of IRQs
set_affinity() {
    local start_irq=$1
    local end_irq=$2
    local affinity=0
    local iteration_count=0

    for irq in $(seq $start_irq $end_irq); do
        echo $affinity > /proc/irq/$irq/smp_affinity_list
        echo "IRQ $irq smp_affinity_list set to $affinity"
        
        iteration_count=$((iteration_count + 1))

        affinity=$((affinity + 1))

        # After the 10th iteration, increase affinity by 10 only once
        if [ "$iteration_count" -eq 10 ]; then
            affinity=$((affinity + 10))
            echo "Increased affinity by 10 after 10th iteration"
        fi
    done
}

# Check the input string and perform actions accordingly
if [ "$server_name" == "icelake1" ]; then
    set_affinity 690 752
elif [ "$server_name" == "icelake2" ]; then
    set_affinity 425 487
else
    echo "Unknown server name: $server_name"
    exit 1
fi