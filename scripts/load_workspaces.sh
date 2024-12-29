#!/bin/bash

get_current_workspace() {
    i3-msg -t get_workspaces | jq '.[] | select(.focused == true).num'
}

load_preset_0() {
    (firefox https://github.com/ghazinator/config \
            https://archlinux.org/ &)

    (alacritty -e bash -c "nvim ~/.config/i3/config \
                ~/.config/scripts/load_workspaces.sh \
                ~/.config/nvim/init.vim \
                ~/.config/i3blocks/config; $SHELL" &)
    sleep 0.1
    (alacritty -e bash -c "htop; $SHELL" &)
}

load_preset_1() {
    (discord &)
}

load_preset_2() {
    (firefox https://www.youtube.com/ https://destiny.gg &)
    sleep 0.1
    (firefox https://www.reddit.com/ https://bsky.app/ &)
}

load_preset_3() {
    (firefox https://mail.google.com/ https://www.linkedin.com/feed/ \
            https://chat.com &)
    sleep 0.1

    (zathura Documents/Resume/coverletter.pdf &)
    (alacritty -e nvim -c "VimtexCompile" Documents/Resume/coverletter.tex &)
    sleep 0.1
    (zathura Documents/Resume/resume.pdf &)
    (alacritty -e nvim -c "VimtexCompile" Documents/Resume/resume.tex \
                Documents/Resume/resumebody.tex &)
}

load_preset_8() {
    (steam &)
}

load_preset_9() {
    (helvum &)
    sleep 0.1
    (GTK_THEME=Adwaita:dark pavucontrol &)
}

# Toggle this variable to switch between modes
use_original_functionality=true  

preset_num=$(i3-input -P 'Enter preset number: ' -F '%s' | tail -n 1)
preset_num="${preset_num: -1}" # Extract the last character

current_workspace=$(get_current_workspace)

if $use_original_functionality; then
    case "$preset_num" in
        [0-9])
            i3-msg -t command "[workspace=\"$preset_num\"] kill" 
            sleep 0.1
            i3-msg -t command "workspace \"$preset_num\""
            i3-msg -t command 'append_layout ~/.config/i3workspaces/workspace_'${preset_num}'.json'
            "load_preset_$preset_num"
            ;;
        *) echo "Invalid preset number" ;;
    esac
else
    case "$preset_num" in
        0) 
            i3-msg -t command '[workspace="0"] kill'
            sleep 0.1
            i3-msg -t command 'workspace "0"'
            i3-msg -t command 'append_layout ~/.config/i3workspaces/workspace_0.json'
            load_preset_0
            ;;
        [1-9])
            i3-msg -t command "[workspace=\"$current_workspace\"] kill" 
            sleep 0.1
            i3-msg -t command "workspace \"$current_workspace\""
            i3-msg -t command 'append_layout ~/.config/i3workspaces/workspace_'${preset_num}'.json'
            "load_preset_$preset_num"
            ;;
        *) echo "Invalid preset number" ;;
    esac
fi
