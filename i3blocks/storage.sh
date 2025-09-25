#!/bin/bash

# Collect values (in 1B blocks)
used=$(df -B1 --output=used / | tail -1)
avail=$(df -B1 --output=avail / | tail -1)
total=$((used + avail))

# Convert available to GiB for display
avail_gib=$(awk -v a=$avail 'BEGIN {printf "%.1f GiB", a/1024/1024/1024}')

# Calculate percentage free
percent_free=$(( 100 * avail / total ))

# First line: full text
echo "$avail_gib"
# Second line: short text
echo "$avail_gib"

# Third line: color thresholds (by %)
if (( percent_free < 15 )); then
    echo "#ff0000"   # red if < 5% free
elif (( percent_free < 30 )); then
    echo "#f9f900"   # yellow if < 20% free
else
    echo "#ffffff"   # white otherwise
fi

