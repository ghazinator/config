#!/usr/bin/env bash
# Usage: resize_by_height.sh [WIDTH_RATIO] [HEIGHT_RATIO]
# Defaults to 9:16 (portrait). Example: resize_by_height.sh 9 16

set -euo pipefail

WR="${1:-9}"   # width part of ratio
HR="${2:-16}"  # height part of ratio

TREE_JSON="$(i3-msg -t get_tree)"
FOCUSED_JSON="$(printf '%s' "$TREE_JSON" | jq '.. | objects | select(.focused? == true)')"
[ -n "$FOCUSED_JSON" ] || exit 0

W=$(printf '%s' "$FOCUSED_JSON" | jq -r '.rect.width')
H=$(printf '%s' "$FOCUSED_JSON" | jq -r '.rect.height')
FLOATING=$(printf '%s' "$FOCUSED_JSON" | jq -r '.floating')

# Compute target width from current height
TW=$(awk -v h="$H" -v wr="$WR" -v hr="$HR" 'BEGIN{printf "%d\n", int((h*wr)/hr + 0.5)}')
TH="$H"

if [ "$FLOATING" = "user_on" ] || [ "$FLOATING" = "auto_on" ]; then
  # Floating: set exact size
  i3-msg "resize set width ${TW}px height ${TH}px" >/dev/null
else
  # Tiled: adjust width by delta
  delta=$((TW - W))
  [ "$delta" -eq 0 ] && exit 0
  abs=$(( delta < 0 ? -delta : delta ))
  if [ "$delta" -gt 0 ]; then
    i3-msg "resize grow width ${abs} px" >/dev/null
  else
    i3-msg "resize shrink width ${abs} px" >/dev/null
  fi
fi

