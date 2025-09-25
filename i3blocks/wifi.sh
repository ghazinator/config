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

# Auto-detect Wi-Fi interface
iface=$(iw dev 2>/dev/null | awk '$1=="Interface"{print $2; exit}')
[ -z "$iface" ] && iface="wlan0"  # fallback

ip=$(ip -4 -o addr show "$iface" 2>/dev/null | awk '{print $4}' | cut -d/ -f1)
linkinfo=$(iw dev "$iface" link 2>/dev/null)

if echo "$linkinfo" | grep -q "Not connected"; then
  echo "W: N/A (N/A at N/A Mb/s)"
  echo "W: N/A"
  echo "#f9f900"  # yellow when disconnected
  exit 0
fi

# Extract signal in dBm
signal=$(echo "$linkinfo" | awk '/signal:/ {print $2; exit}')
# Convert to percentage (clamp 0–100)
percent=$(awk -v s="$signal" 'BEGIN {
  q = 2 * (s + 100);
  if (q < 0) q = 0;
  if (q > 100) q = 100;
  printf "%d", q
}')

# Extract bitrate (prefers tx)
speed=$(echo "$linkinfo" | awk '/tx bitrate:/ {for(i=3;i<=NF;i++) if($i~/^[0-9.]+$/){print $i; exit}}')
[ -z "$speed" ] && speed=$(echo "$linkinfo" | awk '/rx bitrate:/ {for(i=3;i<=NF;i++) if($i~/^[0-9.]+$/){print $i; exit}}')

# Full + short text
echo "W: ${ip:-N/A} (${percent}% at ${speed:-N/A} Mb/s)"
echo "W: ${ip:-N/A}"

# Color (green when connected)
echo "#00f900"

