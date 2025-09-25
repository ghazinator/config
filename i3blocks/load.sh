#!/bin/bash

# Set core count; falls back to nproc if not set.
CORES=${CORES:-12}

# First two lines: the classic "x.xx x.xx x.xx" (1, 5, 15 min)
text=$(awk '{printf "%.2f %.2f %.2f", $1, $2, $3}' /proc/loadavg)
echo "$text"
echo "$text"

# Third line: color by 1-minute load vs. core count
awk -v c="$CORES" '{l=$1;
  if (l >= 0.7*c)      print "#ff0000";   # red: 70–100%+
  else if (l >= 0.5*c) print "#f9f900";   # yellow: 50–70%
  else                 print "#ffffff";   # white: <50%
}' /proc/loadavg
