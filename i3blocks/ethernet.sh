#!/bin/bash

# Handle scroll to switch workspaces without looping
# case "$BLOCK_BUTTON" in
#   4) # scroll up = prev
#      current=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num')
#      if [ "$current" -gt 0 ]; then
#        i3-msg workspace number $((current-1)) >/dev/null
#      fi
#      ;;
#   5) # scroll down = next
#      current=$(i3-msg -t get_workspaces | jq '.[] | select(.focused==true).num')
#      last=$(i3-msg -t get_workspaces | jq '[.[].num] | max')
#      if [ "$current" -lt "$last" ]; then
#        i3-msg workspace number $((current+1)) >/dev/null
#      fi
#      ;;
# esac

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

