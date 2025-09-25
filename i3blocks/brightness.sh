#!/usr/bin/env bash
set -euo pipefail

# Config
dev=${BACKLIGHT_DEVICE:-$(ls -d /sys/class/backlight/nvidia_0 2>/dev/null | head -n1)}
step=${BRIGHTNESS_STEP:-5}

sync_ddc() {
  # Read current and mirror to external via DDC/CI (VCP 0x10)
  local cur max pct
  read -r cur < "$dev/brightness"
  read -r max < "$dev/max_brightness"
  pct=$(( max > 0 ? (100 * cur / max) : 0 ))
  command -v ddcutil >/dev/null && ddcutil setvcp 0x10 "$pct" >/dev/null 2>&1 || true
}

# Mouse actions (only run on clicks; interval/signal runs won't hit ddcutil)
case "${BLOCK_BUTTON:-}" in
  1) brightnessctl set 0%    >/dev/null 2>&1 || true; sync_ddc ;;
  2) brightnessctl set 50%   >/dev/null 2>&1 || true; sync_ddc ;;
  3) brightnessctl set 100%  >/dev/null 2>&1 || true; sync_ddc ;;
  4) brightnessctl set +${step}% >/dev/null 2>&1 || true; sync_ddc ;;
  5) brightnessctl set ${step}%- >/dev/null 2>&1 || true; sync_ddc ;;
  *) : ;;  # interval or signal-triggered run → no ddcutil
esac

# Read current value for display
read -r cur < "$dev/brightness"
read -r max < "$dev/max_brightness"
pct=$(( max > 0 ? (100 * cur / max) : 0 ))

printf "B: %d%%\n" "$pct"

