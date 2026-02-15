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
    cat << EOF
Hello $user
Distro: $(LinDistro)
Kernel: $krnl
Terminal: $term_em
Shell: $sh
$disk
Up for: $up
EOF
}
${base_Info}
