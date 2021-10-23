#!/usr/bin/env bash

white(){
    echo -e "\033[1;37m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}

white " lxc/openvz小鸡TUN是否启用反馈如下" 
$(cat /dev/net/tun) 
green "注意：如上反馈内容末尾显示 << in bad state >>，说明已启用TUN，支持安装WARP，恭喜！"
yellow "注意：如上反馈内容末尾显示 << not permitted >>，说明未启用TUN，不支持安装WARP，请联系VPS厂商开通！"
