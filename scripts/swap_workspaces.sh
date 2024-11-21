#!/bin/bash

# Get the currently focused workspace on each output
i3-msg focus output DP-0
focused_workspace1=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused == true and .output == "'"DP-0"'") | .name')
i3-msg focus output DP-4
focused_workspace2=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused == true and .output == "'"DP-4"'") | .name')

# Get workspaces on each output (store in arrays)
readarray -t workspaces1 <<< $(i3-msg -t get_workspaces | jq -r '.[] | select(.output == "'"DP-0"'") | .name')
readarray -t workspaces2 <<< $(i3-msg -t get_workspaces | jq -r '.[] | select(.output == "'"DP-4"'") | .name')

# Move workspaces to the other output
for workspace in "${workspaces1[@]}"; do 
  i3-msg "workspace \"$workspace\"; move workspace to output DP-4"
done

for workspace in "${workspaces2[@]}"; do
  i3-msg "workspace \"$workspace\"; move workspace to output DP-0"
done

# Restore focused workspaces
i3-msg workspace number $focused_workspace2
i3-msg workspace number $focused_workspace1
