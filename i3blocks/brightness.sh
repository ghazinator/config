#!/usr/bin/env bash
set -euo pipefail

# Config
dev=${BACKLIGHT_DEVICE:-$(ls -d /sys/class/backlight/nvidia_0 2>/dev/null | head -n1)}
step=${BRIGHTNESS_STEP:-5}

# Apply click/scroll actions first so printed value is post-change
case "${BLOCK_BUTTON:-}" in
  1) command -v brightnessctl >/dev/null && brightnessctl set 0% >/dev/null 2>&1 || true ;;
  2) command -v brightnessctl >/dev/null && brightnessctl set 50% >/dev/null 2>&1 || true ;;
  3) command -v brightnessctl >/dev/null && brightnessctl set 100%  >/dev/null 2>&1 || true ;;
  4) command -v brightnessctl >/dev/null && brightnessctl set +${step}% >/dev/null 2>&1 || true ;;
  5) command -v brightnessctl >/dev/null && brightnessctl set ${step}%- >/dev/null 2>&1 || true ;;
  *) : ;;
esac

# Read current value
read -r cur < "$dev/brightness"
read -r max < "$dev/max_brightness"
pct=$(( max > 0 ? (100 * cur / max) : 0 ))

# Mirror the same percent to external monitor(s) via DDC/CI
# command -v ddcutil >/dev/null && ddcutil setvcp 10 "$pct" >/dev/null 2>&1 || true  # NEW

# Pick icon by percentage
# if   (( pct <= 30 ));   then icon="󰃞"   # low
# elif (( pct < 80 ));   then icon="󰃟"   # medium
# else                     icon="󰃠"   # high
# fi

icon=B:

printf "%s %d%%\n" "$icon" "$pct"
