#!/usr/bin/env bash

bblue(){
    echo -e "\033[1;34m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
white(){
    echo -e "\033[1;37m\033[01m$1\033[0m"
}
vi=`systemd-detect-virt`

get_char() {
    SAVEDSTTY=`stty -g`
    stty -echo
    stty cbreak
    dd if=/dev/tty bs=1 count=1 2> /dev/null
    stty -raw
    stty echo
    stty $SAVEDSTTY
}

if [[ ${vi} == "lxc" || ${vi} == "openvz" ]]; then
red "lxc/openvz小鸡TUN是否启用反馈如下 cat: /dev/net/tun:………… " 
$(cat /dev/net/tun) 
green "注意：显示 << File descriptor in bad state >>，说明已启用TUN，支持安装WARP，恭喜！"
yellow "注意：显示 << Operation not permitted >>，说明未启用TUN，不支持安装WARP，请联系VPS厂商开通！"
white "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
fi
green "如已启用TUN，请按任意键继续"
yellow "如未启用TUN，请按Ctrl+C，退出脚本"
char=$(get_char)

