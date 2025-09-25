#!/usr/bin/env bash
set -euo pipefail

# Mouse actions (only run on clicks; normal redraws do nothing extra)
case "${BLOCK_BUTTON:-}" in
  1|3) pactl set-sink-mute @DEFAULT_SINK@ toggle ;;                # left/right click: mute toggle
  2)   command -v pavucontrol >/dev/null && pavucontrol &>/dev/null & ;;  # middle: open mixer
  4)   pactl set-sink-volume @DEFAULT_SINK@ +1% ;;                 # scroll up: +1%
  5)   pactl set-sink-volume @DEFAULT_SINK@ -1% ;;                 # scroll down: -1%
  *) : ;;
esac

# Read back state for display
vol_line=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | head -n1 || true)
vol=${vol_line#*/}; vol=${vol%%/*}; vol=${vol//[[:space:]]/}; vol=${vol%%%}
mute=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}')
vol_int=${vol:-0}

icon="V:"

if [[ "$mute" == "yes" ]]; then
  printf "V: %s%% [Muted]\n" "$vol"
else
  printf "V: %s%%\n" "$vol"
fi

