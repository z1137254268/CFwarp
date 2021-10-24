#!/usr/bin/env bash

red(){
    echo -e "\033[31m\033[01m$1\033[0m"
}
green(){
    echo -e "\033[32m\033[01m$1\033[0m"
}
yellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}
blue(){
    echo -e "\033[36m\033[01m$1\033[0m"
}
white(){
    echo -e "\033[1;37m\033[01m$1\033[0m"
}
bblue(){
    echo -e "\033[1;34m\033[01m$1\033[0m"
}
rred(){
    echo -e "\033[1;35m\033[01m$1\033[0m"
}
AE="阿联酋";AU="澳大利亚";BR="巴西";CA="加拿大";CH="瑞士";CL="智利";CN="中国";DE="德国";ES="西班牙";FI="芬兰";FR="法国";HK="香港";ID="印尼";IE="爱尔兰";IL="以色列";IN="印度";IT="意大利";JP="日本";KR="韩国";MY="马来西亚";NL="荷兰";NZ="新西兰";PH="菲律宾";RU="俄罗斯";SA="沙特";SE="瑞典";SG="新加坡";TW="台湾";UK="英国";US="美国";VN="越南";ZA="南非"
wg-quick down wgcf >/dev/null 2>&1
systemctl restart wg-quick@wgcf >/dev/null 2>&1
wg-quick up wgcf >/dev/null 2>&1
v4=$(wget -T1 -t1 -qO- -4 ip.gs)
v6=$(wget -T1 -t1 -qO- -6 ip.gs)
until [[ -n $v4 || -n $v6 ]]
do
wg-quick down wgcf >/dev/null 2>&1
wg-quick up wgcf >/dev/null 2>&1
v4=$(wget -T1 -t1 -qO- -4 ip.gs)
v6=$(wget -T1 -t1 -qO- -6 ip.gs)
done
if [[ -n ${v4} ]]; then
gj4=`curl -s4 https://ip.gs/country-iso`
g4=$(eval echo \$$gj4)
WARPIPv4Status=$(curl -s4 https://www.cloudflare.com/cdn-cgi/trace | grep warp | cut -d= -f2) 
case ${WARPIPv4Status} in 
plus) 
WARPIPv4Status=$(green "WARP+PLUS已开启，当前IPV4地址：$v4 ，IP所在区域：$g4 ") 
;;  
on) 
WARPIPv4Status=$(green "WARP已开启，当前IPV4地址：$v4 ，IP所在区域：$g4 ") 
;; 
off) 
WARPIPv4Status=$(yellow "WARP未开启，当前IPV4地址：$v4 ，IP所在区域：$g4")
esac 
else
WARPIPv4Status=$(red "不存在IPV4地址 ")
fi 

if [[ -n ${v6} ]]; then 
gj6=`curl -s6 https://ip.gs/country-iso`
g6=$(eval echo \$$gj6)
WARPIPv6Status=$(curl -s6 https://www.cloudflare.com/cdn-cgi/trace | grep warp | cut -d= -f2) 
case ${WARPIPv6Status} in 
plus) 
WARPIPv6Status=$(green "WARP+PLUS已开启，当前IPV6地址：$v6 ，IP所在区域：$g6 ") 
;;  
on) 
WARPIPv6Status=$(green "WARP已开启，当前IPV6地址：$v6 ，IP所在区域：$g6 ") 
;; 
off) 
WARPIPv6Status=$(yellow "WARP未开启，当前IPV6地址：$v6 ，IP所在区域：$g6 ") 
esac 
else
WARPIPv6Status=$(red "不存在IPV6地址 ")
fi 

green "刷新IP成功，当前WARP及IP状态如下 "
blue "WARP状态+IPv4地址+IP所在区域: ${WARPIPv4Status}"
blue "WARP状态+IPv6地址+IP所在区域: ${WARPIPv6Status}"

