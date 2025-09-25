#!/bin/bash
iface=enp65s0

ip=$(ip -4 -o addr show $iface | awk '{print $4}' | cut -d/ -f1)
speed=$(cat /sys/class/net/$iface/speed 2>/dev/null)

if [[ -n "$ip" && "$speed" != "-1" ]]; then
    echo "E: $ip (${speed} Mbit/s)"
    echo "E: $ip"
    echo "#00f900"    # green
else
    echo "E: N/A"
    echo "E: N/A"
    echo "#f9f900"    # yellow
fi

