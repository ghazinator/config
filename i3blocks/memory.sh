#!/bin/bash

# Grab used and available in GiB
read used avail <<<$(free -m | awk '/Mem:/ {printf "%.1f %.1f", $3/1024, $7/1024}')

# Full + short text
echo "${used} GiB | ${avail} GiB"
echo "${used} GiB | ${avail} GiB"

# echo "${used} GiB"
# echo "${used} GiB"

# Total memory for % calc
total=$(free -m | awk '/Mem:/ {print $2}')
percent_used=$(awk -v u=$used -v t=$total 'BEGIN {print (u*1024)/t*100}')

# Color thresholds
if (( ${percent_used%.*} >= 70 )); then
    echo "#ff0000"   # red if ≥70% used
elif (( ${percent_used%.*} >= 50 )); then
    echo "#f9f900"   # yellow if 50–70% used
else
    echo "#ffffff"   # white otherwise
fi

