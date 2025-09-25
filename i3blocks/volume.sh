#!/usr/bin/env bash
set -euo pipefail

# Apply click actions first so the printed value is post-change
case "${BLOCK_BUTTON:-}" in
  1|3)   pactl set-sink-mute @DEFAULT_SINK@ toggle ;;
  2)   command -v pavucontrol >/dev/null && pavucontrol &>/dev/null & ;;
  4)   pactl set-sink-volume @DEFAULT_SINK@ +1% ;;
  5)   pactl set-sink-volume @DEFAULT_SINK@ -1% ;;
  *) : ;;
esac

# Read back state
vol_line=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | head -n1 || true)
vol=${vol_line#*/}; vol=${vol%%/*}; vol=${vol//[[:space:]]/}; vol=${vol%%%}
mute=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | awk '{print $2}')
vol_int=${vol:-0}

# Icon map
# muted: 󰝟, 0‑33: 󰕿, 34‑66: 󰖀, 67‑100: 󰕾
# if [[ "$mute" == "yes" ]]; then
#   icon="󰝟"
# elif (( vol_int <= 15 )); then
#   icon="󰕿"
# elif (( vol_int <= 45 )); then
#   icon="󰖀"
# else
#   icon="󰕾"
# fi

icon=V:

if [[ "$mute" == "yes" ]]; then
  printf "%s %s%% [Muted]\n" "$icon" "$vol"
else
  printf "%s %s%%\n" "$icon" "$vol"
fi
