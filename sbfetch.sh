#!/bin/bash
LinDistro(){
    if [ -f /etc/os-release ]; then
      . /etc/os-release
      echo "$PRETTY_NAME"
    else
      uname -s
    fi
}
base_Info(){
    local user=$(id -un)
    local up=$(uptime -p | cut -c4-)
    local disk=$(df -h / | awk 'NR==2 {print "Storage: " $3 "/" $2 " ("$5")"}')
    local term_em=$(echo $TERM)
    local sh=$(basename "$SHELL")
    local krnl=$(uname -r)
    local wm-de=$(echo $XDG_CURRENT_DESKTOP)
    local home=$(cat /etc/hostname 2>/dev/null || hostname)
    cat << EOF
Hello $user/$home
Distro: $(LinDistro)
Kernel: $krnl
WM/DE: $wm-de
Terminal: $term_em
Shell: $sh
$disk
Up for: $up
EOF
}
base_Info
