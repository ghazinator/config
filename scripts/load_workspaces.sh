#!/bin/bash

# i3-save-tree --workspace "x" > workspace_x.json

# Function to load workspace 0
load_workspace_0() {
    i3-msg '[workspace="0"] kill'
    i3-msg '[workspace="0: config"] kill'
    sleep 0.1
    i3-msg 'workspace "0"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_0.json'

    (firefox https://github.com/ghazinator/config \
        https://wiki.archlinux.org/title/Main_page &)
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
    i3-msg '[workspace="1: discord"] kill'
    sleep 0.1
    i3-msg 'workspace "1"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_1.json'

    (discord &)
    sleep 0.1
    i3-msg 'rename workspace 1 to "1: discord"'
}

load_workspace_2() {
    i3-msg '[workspace="2"] kill'
    i3-msg '[workspace="2: firefox"] kill'
    sleep 0.1
    i3-msg 'workspace "2"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_2.json'

    (firefox https://destiny.gg https://www.youtube.com/ \
    https://www.reddit.com/ https://bsky.app/ &)
    sleep 0.1
    i3-msg 'rename workspace 2 to "2: firefox"'
}

load_workspace_3() {
    i3-msg '[workspace="3"] kill'
    i3-msg '[workspace="3: resume"] kill'
    sleep 0.1
    i3-msg 'workspace "3"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_3.json'

    (firefox https://mail.google.com/ https://gemini.google.com/app &)
    sleep 0.1

    (alacritty -e bash -c "zathura Documents/Resume/resume.pdf & \
        nvim Documents/Resume/*.tex; $SHELL" &)
    sleep 0.1
    i3-msg 'rename workspace 3 to "3: resume"'
}

load_workspace_7() {
    i3-msg '[workspace="7"] kill'
    i3-msg '[workspace="7: steam"] kill'
    sleep 0.1
    i3-msg 'workspace "7"'
    i3-msg 'append_layout ~f.config/i3workspaces/workspace_7.json'

    (steam &)
    sleep 0.1
    i3-msg 'rename workspace 7 to "7: steam"'
}

load_workspace_8() {
    i3-msg '[workspace="8"] kill'
    i3-msg '[workspace="8: vlc"] kill'
    sleep 0.1
    i3-msg 'workspace "8"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_7.json'

    (vlc &)
    sleep 0.1
    i3-msg 'rename workspace 8 to "8: vlc"'
}

load_workspace_9() {
    i3-msg '[workspace="9"] kill'
    i3-msg '[workspace="9: control"] kill'
    sleep 0.1
    i3-msg 'workspace "9"'
    i3-msg 'append_layout ~/.config/i3workspaces/workspace_9.json'

    (helvum &)
    sleep 0.1
    (GTK_THEME=Adwaita:dark pavucontrol &)
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
    7) load_workspace_7 ;;
    8) load_workspace_8 ;;
    9) load_workspace_9 ;;
    *) echo "Invalid workspace number" ;;
esac

