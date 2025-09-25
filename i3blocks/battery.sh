#!/bin/bash

BAT=/sys/class/power_supply/BAT1
status=$(< $BAT/status)
now=$(< $BAT/energy_now)
full=$(< $BAT/energy_full_design)
percent=$(awk -v n=$now -v d=$full 'BEGIN {print n/d*100}')

if [[ $status == "Charging" ]]; then
    label="CHR"
elif [[ $status == "Discharging" ]]; then
    label="DIS"
elif [[ $status == "Full" ]]; then
    label="FULL"
else
    label="UNK"
fi

# First line: full text
echo "$label $(printf "%.2f%%" "$percent")"
# Second line: short text (optional, keep same here)
echo "$label $(printf "%.0f%%" "$percent")"

# Third line: color
if (( ${percent%.*} < 25 )); then
    echo "#ff0000"   # red
elif (( ${percent%.*} < 50 )); then
    echo "#f9f900"   # yellow
else
    echo "#ffffff"   # white
fi

