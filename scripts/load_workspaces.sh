#!/bin/bash

# i3-save-tree --workspace "x" > workspace_x.json

# Function to load workspace 0
load_workspace_0() {
    i3-msg '[workspace="0"] kill'
    i3-msg '[workspace="0: config"] kill'
    i3-msg 'workspace "0"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_0.json'

    (firefox --new-window https://wiki.archlinux.org/title/Main_page &)
    (alacritty -e bash -c "nvim ~/.config/i3/config \
               ~/.config/scripts/load_workspaces.sh \
                            ~/.config/nvim/init.vim \
                            ~/.config/i3blocks/config; $SHELL" &)
    sleep 0.1
    (alacritty -e bash -c "htop; $SHELL" &)
    sleep 0.1
    i3-msg 'rename workspace 0 to "0: config"'
}

# Function to load workspace 1
load_workspace_1() {
    i3-msg '[workspace="1"] kill'
    i3-msg '[workspace="1: chat"] kill'
    i3-msg 'workspace "1"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_1.json'

    (discord &)
    (firefox --new-window https://web.whatsapp.com/ &)
    sleep 0.1
    i3-msg 'rename workspace 1 to "1: chat"'
}

load_workspace_2() {
    i3-msg '[workspace="2"] kill'
    i3-msg '[workspace="2: www"] kill'
    i3-msg 'workspace "2"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_2.json'

    (firefox https://destiny.gg https://www.youtube.com/ \
    https://www.reddit.com/ https://bsky.app/ &)
    sleep 0.1
    i3-msg 'rename workspace 2 to "2: www"'
}

load_workspace_3() {
    i3-msg '[workspace="3"] kill'
    i3-msg '[workspace="3: batoul"] kill'
    i3-msg 'workspace "3"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_3.json'

    (firefox https://gemini.google.com/app/595e90b03bf9c806 \
        https://gemini.google.com/\
        https://www.wikipedia.org/ &)
    sleep 0.1
    (xdg-open ~/Batoul/A3/A3-2024.docx &)
    sleep 0.1
    (xdg-open ~/Batoul/A3/A3Q2SampleMaxHeap.docx &)
    sleep 0.1
    (alacritty -e bash -c "cd Batoul/A3/Template/. && \
        nvim makefile a3q2_main.c a3q2_functions.c \
        a3q2_header.h; $SHELL" &)
    sleep 0.1
    (alacritty -e bash -c "cd Batoul/A3/Template/. && tree; $SHELL" &)
    sleep 0.1
    (alacritty -e bash -c "cd Batoul/A3/. &&  \
        cat f.dat; $SHELL" &)
    sleep 0.1

    i3-msg 'rename workspace 3 to "3: batoul"'
}

load_workspace_4() {
    i3-msg '[workspace="4"] kill'
    i3-msg '[workspace="4: batoul"] kill'
    i3-msg 'workspace "4"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_3.json'

    (firefox https://gemini.google.com/app/595e90b03bf9c806 \
        https://gemini.google.com/\
        https://www.wikipedia.org/ &)
    sleep 0.1
    (xdg-open ~/Batoul/A3/A3-2024.docx &)
    sleep 0.1
    (xdg-open ~/Batoul/A3/A3Q2SampleMaxHeap.docx &)
    sleep 0.1
    (alacritty -e bash -c "cd Batoul/A3/Template/. && \
        nvim makefile a3q1_main.c a3q1_functions.c \
        a3q1_header.h; $SHELL" &)
    sleep 0.1
    (alacritty -e bash -c "cd Batoul/A3/Template/. && tree; $SHELL" &)
    sleep 0.1
    (alacritty -e bash -c "cd Batoul/A3/. &&  \
        cat A3Q1_Tree_Traverasal_Output.txt; $SHELL" &)
    sleep 0.1

    i3-msg 'rename workspace 4 to "4: batoul"'
}

load_workspace_9() {
    i3-msg '[workspace="9"] kill'
    i3-msg 'workspace "9"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_9.json'

    (qpwgraph &)
    sleep 0.1
    (pavucontrol &)
    sleep 0.1
    i3-msg 'rename workspace 9 to "9: control"'
}

# Get workspace number from i3-input
workspace_num=$(i3-input -P 'Enter workspace number: ' -F '%s' | tail -n 1)
workspace_num="${workspace_num: -1}"  # Extract the last character

# Case switch to load the selected workspace
case "$workspace_num" in
    0) load_workspace_0 ;;
    1) load_workspace_1 ;;
    2) load_workspace_2 ;;
    3) load_workspace_3 ;;
    4) load_workspace_4 ;;
    9) load_workspace_9 ;;
    *) echo "Invalid workspace number" ;;
esac

