#!/usr/bin/env bash
export PATH=$PATH:/usr/local/bin

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

if [[ $(id -u) != 0 ]]; then
yellow " 请以root模式运行脚本。"
exit 0
fi

	if [[ -f /etc/redhat-release ]]; then
		release="Centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="Debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="Ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="Centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="Debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="Ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="Centos"
    fi

if ! type curl >/dev/null 2>&1; then
	   yellow "curl 未安装，安装中 "
           apt update -y && apt install curl -y && yum install curl -y >/dev/null 2>&1
           else
           green "curl 已安装，继续 "
fi

        if ! type wget >/dev/null 2>&1; then
           yellow "wget 未安装 安装中 "
           apt update -y && apt install wget -y && yum install wget -y >/dev/null 2>&1
           else
           green "wget 已安装，继续 "
fi  

bit=`uname -m`
version=`uname -r | awk -F "-" '{print $1}'`
main=`uname  -r | awk -F . '{print $1 }'`
minor=`uname -r | awk -F . '{print $2}'`
rv4=`ip a | grep global | awk 'NR==1 {print $2}' | cut -d'/' -f1`
rv6=`ip a | grep inet6 | awk 'NR==2 {print $2}' | cut -d'/' -f1`
op=`hostnamectl | grep -i Operating | awk -F ':' '{print $2}'`
vi=`hostnamectl | grep -i Virtualization | awk -F ':' '{print $2}'`

warpwg=$(systemctl is-active wg-quick@wgcf)
case ${warpwg} in
active)
     WireGuardStatus=$(green "运行中")
     ;;
*)
     WireGuardStatus=$(red "未运行")
esac


v44=`wget -T1 -t1 -qO- -4 ip.gs`
if [[ -n ${v44} ]]; then
 v4=`wget -qO- -4 ip.gs` 
 WARPIPv4Status=$(curl -s4 https://www.cloudflare.com/cdn-cgi/trace | grep warp | cut -d= -f2) 
 case ${WARPIPv4Status} in 
 on) 
 WARPIPv4Status=$(green "WARP已开启,当前IPV4地址：$v4 ") 
 ;; 
 off) 
 WARPIPv4Status=$(yellow "WARP未开启，当前IPV4地址：$v4 ") 
 esac 
else
WARPIPv4Status=$(red "不存在IPV4地址 ")
fi 

v66=`wget -T1 -t1 -qO- -6 ip.gs`
if [[ -n ${v66} ]]; then
 v6=`wget -qO- -6 ip.gs` 
 WARPIPv6Status=$(curl -s6 https://www.cloudflare.com/cdn-cgi/trace | grep warp | cut -d= -f2) 
 case ${WARPIPv6Status} in 
 on) 
 WARPIPv6Status=$(green "WARP已开启,当前IPV6地址：$v6 ") 
 ;; 
 off) 
 WARPIPv6Status=$(yellow "WARP未开启，当前IPV6地址：$v6 ") 
 esac 
else
WARPIPv6Status=$(red "不存在IPV6地址 ")
fi 

ud4='sed -i "5 s/^/PostUp = ip -4 rule add from $(ip route get 114.114.114.114 | grep -oP '"'src \K\S+') lookup main\n/"'" wgcf-profile.conf && sed -i "6 s/^/PostDown = ip -4 rule delete from $(ip route get 114.114.114.114 | grep -oP '"'src \K\S+') lookup main\n/"'" wgcf-profile.conf'
ud6='sed -i "7 s/^/PostUp = ip -6 rule add from $(ip route get 2400:3200::1 | grep -oP '"'src \K\S+') lookup main\n/"'" wgcf-profile.conf && sed -i "8 s/^/PostDown = ip -6 rule delete from $(ip route get 2400:3200::1 | grep -oP '"'src \K\S+') lookup main\n/"'" wgcf-profile.conf'
ud4ud6='sed -i "5 s/^/PostUp = ip -4 rule add from $(ip route get 114.114.114.114 | grep -oP '"'src \K\S+') lookup main\n/"'" wgcf-profile.conf && sed -i "6 s/^/PostDown = ip -4 rule delete from $(ip route get 114.114.114.114 | grep -oP '"'src \K\S+') lookup main\n/"'" wgcf-profile.conf && sed -i "7 s/^/PostUp = ip -6 rule add from $(ip route get 2400:3200::1 | grep -oP '"'src \K\S+') lookup main\n/"'" wgcf-profile.conf && sed -i "8 s/^/PostDown = ip -6 rule delete from $(ip route get 2400:3200::1 | grep -oP '"'src \K\S+') lookup main\n/"'" wgcf-profile.conf'
c1='sed -i '/0\.0\.0\.0\/0/d' wgcf-profile.conf'
c2='sed -i '/\:\:\/0/d' wgcf-profile.conf'
c3='sed -i 's/engage.cloudflareclient.com/162.159.192.1/g' wgcf-profile.conf'
c4='sed -i 's/engage.cloudflareclient.com/[2606:4700:d0::a29f:c001]/g' wgcf-profile.conf'
c5='sed -i 's/1.1.1.1/8.8.8.8,2001:4860:4860::8888/g' wgcf-profile.conf'
c6='sed -i 's/1.1.1.1/2001:4860:4860::8888,8.8.8.8/g' wgcf-profile.conf'

Print_ALL_Status_menu() {
white "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
yellow " VPS相关信息如下："
blue " 操作系统名称 -$op "
blue " 系统内核版本 - $version " 
blue " CPU架构名称  - $bit "
blue " 虚拟架构类型 -$vi "
white "------------------------------------------"
blue " WGCF 运行状态\t: ${WireGuardStatus}"
blue " IPv4 网络状态\t: ${WARPIPv4Status}"
blue " IPv6 网络状态\t: ${WARPIPv6Status}"
white "------------------------------------------"
}

function ins(){
rm -f /usr/local/bin/wgcf /etc/wireguard/wgcf.conf /etc/wireguard/wgcf-account.toml /usr/bin/wireguard-go
	
	if [ $release = "Centos" ]; then  
yum -y install epel-release
yum -y install curl net-tools wireguard-tools		
yellow " 检测系统内核版本是否大于5.6版本 "
if [ "$main" -lt 5 ]|| [ "$minor" -lt 6 ]; then true
if [[ ${vi} == " kvm" || ${vi} == " xen" || ${vi} == " microsoft" ]]; then
curl -Lo /etc/yum.repos.d/wireguard.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-7/jdoss-wireguard-epel-7.repo
yum -y install epel-release wireguard-dkms
fi
fi	
yum -y update

elif [ $release = "Debian" ]; then
apt update -y 
apt -y install lsb-release
echo "deb http://deb.debian.org/debian $(lsb_release -sc)-backports main" | tee /etc/apt/sources.list.d/backports.list
apt update -y
apt -y --no-install-recommends install net-tools iproute2 openresolv dnsutils wireguard-tools               		
yellow " 检测系统内核版本是否大于5.6版本 "
if [ "$main" -lt 5 ]|| [ "$minor" -lt 6 ]; then true
if [[ ${vi} == " kvm" || ${vi} == " xen" || ${vi} == " microsoft" ]]; then
apt -y --no-install-recommends install linux-headers-$(uname -r);apt -y --no-install-recommends install wireguard-dkms
fi
fi		
apt update -y
	
elif [ $release = "Ubuntu" ]; then
apt update -y  
apt -y --no-install-recommends install net-tools iproute2 openresolv dnsutils wireguard-tools			
else 
red " 不支持你当前系统，请选择Ubuntu,Debain,Centos系统 "
rm -f 1.sh
exit 1
fi

	latest=$(wget --no-check-certificate -qO- -t1 -T2 "https://api.github.com/repos/ViRb3/wgcf/releases/latest" | grep "tag_name" | head -n 1 | cut -d : -f2 | sed 's/\"//g;s/v//g;s/,//g;s/ //g')
	[[ -z $latest ]] && latest='2.2.8'

	wget -N --no-check-certificate -O /usr/local/bin/wgcf https://github.com/ViRb3/wgcf/releases/download/v$latest/wgcf_${latest}_linux_$architecture

	chmod +x /usr/local/bin/wgcf

if [[ ${vi} == " lxc" || ${vi} == " OpenVZ" ]]; then
wget -N --no-check-certificate https://cdn.jsdelivr.net/gh/kkkyg/1/wireguard-go -O /usr/bin/wireguard-go
chmod +x /usr/bin/wireguard-go
fi

	echo | wgcf register
until [[ -e wgcf-account.toml ]]
do
sleep 1s
echo | wgcf register
done
wgcf generate

echo $ABC1 | sh
echo $ABC2 | sh
echo $ABC3 | sh
echo $ABC4 | sh
echo $ABC5 | sh

mv -f wgcf-profile.conf /etc/wireguard/wgcf.conf
mv -f wgcf-account.toml /etc/wireguard/wgcf-account.toml

systemctl enable wg-quick@wgcf >/dev/null 2>&1

[[ -e /etc/gai.conf ]] && [[ $(grep '^[ ]*precedence[ ]*::ffff:0:0/96[ ]*100' /etc/gai.conf) ]] || echo 'precedence ::ffff:0:0/96  100' >> /etc/gai.conf

yellow " 检测是否成功启动（IPV4+IPV6）双栈Warp！\n 显示IPV4地址：$(wget -T1 -t1 -qO- -4 ip.gs) 显示IPV6地址：$(wget -T1 -t1 -qO- -6 ip.gs) "
green " 如上方显示IPV4地址：8.…………，IPV6地址：2a09:…………，则说明成功啦！\n 如上方IPV4无IP显示,IPV6显示本地IP,则说明失败喽！！ "
}

function start_menu(){
    clear
    yellow " 详细说明 https://github.com/kkkyg/CFwarp  YouTube频道：甬哥侃侃侃" 
    
    red " 切记：进入脚本快捷方式 bash multi.sh "
    
    white " ==================一、VPS相关调整选择（更新中）==========================================" 
    
    green " 1. 永久开启甲骨文VPS的ubuntu系统所有端口 "
    
    green " 2. 更新系统内核 "
    
    green " 3. 开启原生BBR加速 "
    
    green " 4. 检测奈飞Netflix是否解锁 "
    
    white " ==================二、“内核集成模式”WARP功能选择（更新中）======================================"
    
    yellow " ----VPS原生IP数------------------------------------添加WARP虚拟IP的位置--------------"
    
    green " 5. 纯IPV4的VPS。                                         添加WARP虚拟IPV4               "
    
    green " 6. 纯IPV4的VPS。                                         添加WARP虚拟IPV6      "
    
    green " 7. 纯IPV4的VPS。                                         添加WARP虚拟IPV4+虚拟IPV6              "
    
    green " 8. 纯IPV6的VPS。                                         添加WARP虚拟IPV4               "
    
    green " 9. 纯IPV6的VPS。                                         添加WARP虚拟IPV6     "
    
    green " 10. 纯IPV6的VPS。                                        添加WARP虚拟IPV4+虚拟IPV6               " 
    
    green " 11. 双栈IPV4+IPV6的VPS。                                  添加WARP虚拟IPV4               "
    
    green " 12. 双栈IPV4+IPV6的VPS。                                  添加WARP虚拟IPV6      "
    
    green " 13. 双栈IPV4+IPV6的VPS。                                  添加WARP虚拟IPV4+虚拟IPV6               "
    
    white " ------------------------------------------------------------------------------------------------"
    
    green " 14. 统一DNS功能 "
    
    green " 15. 永久关闭WARP功能 "
    
    green " 16. 自动开启WARP功能 "
    
    green " 17. 有IPV4：更新脚本 "
    
    green " 18. 无IPV4：更新脚本 "
    
    white " ==================三、代理协议脚本选择（更新中）==========================================="
    
    green " 19.使用mack-a脚本（支持Xray, V2ray） "
    
    green " 20.使用phlinhng脚本（支持Xray, Trojan-go, SS+v2ray-plugin） "
    
    white " ============================================================================================="
    
    green " 21. 重启VPS实例，请重新连接SSH "
    
    white " ===============================================================================================" 
    
    green " 0. 退出脚本 "
    Print_ALL_Status_menu
    echo
    read -p "请输入数字:" menuNumberInput
    case "$menuNumberInput" in 
    
        1 )
           iptables
	;;
	2 )
           upcore
	;;
        3 )
           BBR
	;;
	4 )
           Netflix
	;;    
        5 )
           ABC=${u4} && ${d4} && ${c3} && ${c2} && ${c5}; ins
	;;
        6 )
           ABC=${c3} && ${c1} && ${c5}}; ins
	;;
        7 )
           ABC1=${ud4} && ABC2=${c3} && ABC3=${c5}; ins
	;;
        8 )
           ABC=${c4} && ${c2} && ${c5}; ins
	;;
        9 )
           u6 d6 c1 c6;          ins
	   ;;
	10 )   
	   ABC1=${ud6} && ABC2=${c4} && ABC3=${c5}; ins
	   ;;
	11 )
           ABC=${u4} && ${d4} && ${c2} && ${c5}; ins
	;;
	12 )
           ABC=${u6} && ${d6} && ${c1} && ${c5}; ins
	;;
	13 )
           ABC=${u4} && ${d4} && ${u6} && ${d6} && ${c5}; ins
	;;
	14 )
           dns
	;;
	15 )
           cwarp
	;;
	16 )
           owarp
	;;
	17 )
           up4
	;;
	18 )
           up6
	;;
	19 )
           macka
	;;
	20 )
           phlinhng
	;;
	21 )
           reboot
	;;
        0 )
            exit 1
        ;;
    esac
}


start_menu "first" 
