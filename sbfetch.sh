#!/bin/bash
normal=$(printf '\033[0m')
yellow=$(printf '\033[33m')
red=$(printf '\033[31m')
green=$(printf '\033[32m')
orange=$(printf '\033[38;5;208m')
br=$(echo )
LinDistro(){
    if [ -f /etc/os-release ]; then
      . /etc/os-release
      echo "$PRETTY_NAME"
    else
      uname -s
    fi
}
Wifi(){
  echo "${yellow}Testing${normal} connection to ${orange}sdgscryv.xyz${normal}"
  if ping -c 1 sdgscryv.xyz >/dev/null; then
    echo "${yellow}Internet${normal} test ${green}passed${normal}"
  else
    echo "${yellow}Internet${normal} test ${red}failed${normal}"
  fi
}


user=$(id -un)
up=$(uptime -p | cut -c4-)
disk=$(df -h / | awk 'NR==2 {print "Storage: " $3 " / " $2 " ("$5")"}')
term_em=$(echo $TERM)
sh=$(basename "$SHELL")
krnl=$(uname -r)
wm=$(echo $XDG_CURRENT_DESKTOP)
home=$(cat /etc/hostname 2>/dev/null || hostname)
cpu=$(lscpu | grep 'Model name' | cut -f 2 -d ":" | awk '{$1=$1}1')
gpu=$(lspci 2>/dev/null | grep -i --color=never 'vga\|3d\|display' | sed 's/.*: //;s/(rev [0-9a-f]*)//g' || echo "Unknown")
totmem=$(free -g | grep Mem: | awk '{print $2}')
memu=$(free -g | grep Mem: | awk '{print $3}')
    
    cat << EOF
      .--..-'''-''''-._
  ___/%   ) )      \ i-;;,_
((:___/--/ /--------\ ) 
         ""          ""
${yellow}Hello ${normal}$user/$home
${yellow}Up for:${normal} $up
───────────────────────────────────
${yellow}Distro:${normal} $(LinDistro)
${yellow}Kernel: ${normal}$krnl
${yellow}Terminal:${normal} $term_em
${yellow}Shell:${normal} $sh
${yellow}WM/DE:${normal} $wm
───────────────────────────────────
${yellow}Storage:${normal} $disk
${yellow}CPU:${normal} $cpu
${yellow}GPU:${normal} $gpu
${yellow}Memory:${normal} ${memu} GIB / ${totmem} GIB
${br}
$(Wifi)
EOF

