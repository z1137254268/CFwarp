### 公测！！

### 还有几个功能的加减，正式版将配合教程视频一起发布。。快了。。

### 2021.10.24重大更新：自动识别VPS类型（纯V4，纯V6，双栈V4V6）并给出相应的WARP配置方案，防止之前全盘显示后误选失联问题，优化每个选项退出机制。

### 2021.10.23更新：加入对openvz与lxc vps是否启用TUN的判断机制。。

### 2021.10.22更新：正式支持hax站的纯ipv6的kvm与openvz，注意：openvz请先在网页后台开启tun后重启vps

### 2021.10.6更新内容

1：自动选择适合你小鸡的WARP模式：

内核版本大于5.6安装内核集成模式。小于5.6安装内核模块模式。lxc与OpenVZ架构安装wireguard-go模式

2：中文显示IP所属国家名称

3：支持WARP+账户及显示

4：加入无限刷WARP+流量功能（方法如下）

下载好手机APP名称：1.1.1.1

添加WARP+账户提示26字符：右上角设置-账户-按键-复制许可证秘钥

刷WARP+流量提示36字符：右上角设置-高级-诊断-复制客户端配置ID

APP显示warp+流量更新：右上角设置-高级-连接选项-重置安全密钥，再回到APP主界面即可显示最新WARP+流量数据

提示400 bad request：密钥ID输入错误或者绑定设备数超过5个

超过5个设备如何删减：右上角设置-账户-管理设备，点暗不要的设备

5：脚本内置重启vps时，WARP自动刷新warp的ip，防止WARP运行过程中失效！

有意见提ISSUES！！

WARP+账户对速度没有什么影响，装B可以！大家回车跳过就行，但后续测试应用教程会更新！
 
### 以下说明文档还没更新！还没有更新！还没有更新！。请等待。目前甬哥比较忙。

关注甬哥侃侃侃油管频道：https://www.youtube.com/channel/UCxukdnZiXnTFvjF5B5dvJ5w

----------------------------------------------------------------------------------------------------------------------

## 支持KVM、lxc等架构VPS的WARP一键综合脚本

- [x] 支持自动识别系统类型，CPU架构(X86/ARM)，内核版本，虚拟化架构类型！
- [x] 支持纯IPV4，纯IPV6，双栈IPV4+IPV6 三大类kvm VPS！
- [x] 支持Ubuntu/Centos/Debain最新系统！
- [x] 支持共9种形态的WARP形式，安装过程无需手动干预！
- [x] 支持即时显示当前WARP状态、IP地址、IP国家！

最新一键脚本：
```
wget -N --no-check-certificate https://cdn.jsdelivr.net/gh/z1137254268/CFwarp/CFwarp.sh && chmod +x CFwarp.sh && ./CFwarp.sh
```

进入脚本快捷方式 ```bash CFwarp.sh```


### 相关视频教程及项目

待更新 

EUserv德鸡DIG9用户请先执行

```
echo -e "search blue.kundencontroller.de\noptions rotate\nnameserver 2a02:180:6:5::1c\nnameserver 2a02:180:6:5::4\nnameserver 2a02:180:6:5::1e\nnameserver 2a02:180:6:5::1d" > /etc/resolv.conf
```
---------------------------------------------------------------------------------------------

 
### 提醒：

不建议使用Docker，因为目前与WARP模式不兼容。

--------------------------------------------------------------------------------------------

# 目录

* [vps的ip套上warp功能的优势及不足](#vps的ip套上warp功能的优势及不足)

* [warp多功能一键脚本](#warp多功能一键脚本)

* [warp多功能一键脚本各功能简析](#warp多功能一键脚本各功能简析)

* [自定义ip分流配置模板说明](#自定义ip分流配置模板说明)

* [相关附加说明](#相关附加说明)

-----------------------------------------------------------------------------------------
### vps的ip套上warp功能的优势及不足

<details>
<summary>给纯IPV4/纯IPV6 VPS添加WARP的好处</summary>

```bash
1：使只有IPV4/IPV6的VPS获取访问IPV6/IPV4的能力，套上WARP的ip，变成双栈VPS！

2：基本能隐藏VPS的真实IP！

3：加速VPS到CloudFlare CDN节点访问速度！

4：避开原VPS的IP需要谷歌验证码问题！

5：原IPV4下，WARP的IPV6替代HE tunnelbroker IPV6的隧道代理方案，做IPV6 VPS跳板机代理更加稳定！
```
</details>

<details>
<summary>给IPV4+IPV6双栈VPS添加WARP的好处</summary>
    
```bash
1：基本能隐藏VPS的真实IP！

2：WARP分配的IPV4或者IPV6的IP段，都支持奈非Netflix流媒体，无视VPS原IP限制！

3：加速VPS到CloudFlare CDN节点访问速度！

4：避开原VPS的IP需要谷歌验证码问题！
```
</details>

<details>
<summary>不稳定或者不足点</summary>
    
```bash
1：warp的IP与原生IP在Youtube上速度对比，并不一定有优势，具体看网络环境！
    
2：warp的IP归属国家一般与原生IP一致，但可能会自动改变！

3：由于warp是虚拟的IP，类似宝塔面板等相关工具可能需要另外的设置，请自行谷歌。
```
</details>

-------------------------------------------------------------------------------------------------------
### warp多功能一键脚本

- **：支持X86/ARM架构的纯IPV4、纯IPV6、双栈IPV4+IPV6 VPS脚本**

```
wget -N --no-check-certificate https://cdn.jsdelivr.net/gh/kkkyg/CFwarp/CFwarp.sh && chmod +x CFwarp.sh && ./CFwarp.sh
```

进入脚本快捷方式 ```bash CFwarp.sh```

- [刷新脚本](https://purge.jsdelivr.net/gh/kkkyg/CFwarp/CFwarp.sh)

---------------------------------------------------------------------------------------------------

### warp多功能一键脚本各功能简析

- **一、开启甲骨文VPS所有端口（甲骨文专用，务必选择）：**

解决代理协议申请证书发生Nginx等相关报错问题，完成后将自动断开VPS连接！

- **二、更新系统内核：**

因为5.6版本以上内核才集成Wireguard，内核集成方案在理论上网络效率最高！（网络性能：内核集成>内核模块>Wireguard-Go）

而网络上很多项目大多都为“内核模块”方案。所以本项目就来pro版的，后续随着VPS厂商对系统的升级，内核集成必定是主流。

自动检测内核版本功能已集成于5-13脚本中，5.6以下内核将自动终止脚本运行并提示升级内核！

更新完成后将自动断开VPS连接！

- **三、开启原生BBR加速：**

检测原生BBR是否生效，最后显示有tcp_bbr字样，说明成功。

- **四、奈非Netflix检测(sjlleo版)：**

支持IPV4/IPV6检测，结果非常详细。

![4f396307256bfefd7c92d6f667fea45](https://user-images.githubusercontent.com/80431714/121798699-62b3b700-cc5a-11eb-81f0-49a0d2fcdaf7.png)


- **五、安装WARP脚本**

- **（仅支持 纯IPV4 VPS）**

脚本5、结果表现为2个IP：VPS本地IPV4+WARP虚拟IPV6

脚本6、结果表现为3个IP：VPS本地IPV4+WARP虚拟IPV4+WARP虚拟IPV6

脚本7、结果表现为2个IP：VPS本地IPV4+WARP虚拟IPV4

- **（仅支持双栈IPV4+IPV6 VPS）**

脚本8、结果表现为3个IP：VPS本地IPV4+VPS本地IPV6+WARP虚拟IPV6

脚本9、结果表现为4个IP：VPS本地IPV4+VPS本地IPV6+WARP虚拟IPV6+WARP虚拟IPV4

脚本10、结果表现为3个IP：VPS本地IPV4+VPS本地IPV6+WARP虚拟IPV4

- **（仅支持 纯IPV6 VPS）**

脚本11、结果表现为2个IP：VPS本地IPV6+WARP虚拟IPV6 （注意、无IPV4）

脚本12、结果表现为3个IP：VPS本地IPV6+WARP虚拟IPV6+WARP虚拟IPV4

脚本13、结果表现为2个IP：VPS本地IPV6+WARP虚拟IPV4

- **六、定时重启VPS功能，：**

VPS可能会强制初始化DNS设置，使WARP设置的DNS失效，导致进入SSH后无法访问外网（如无此问题则无需选择执行）

重启VPS能恢复WARP的DNS并能正常访问外网，现设置为每天早上3点自动重启VPS一次，保证WARP功能正常

- **七、永久关闭WARP功能：**

作用1：永久关闭WARP分配的虚拟IP，还原当前VPS的本地IP。

作用2：如之前已安装了一种WARP方案，现更换另一种WARP方案，请先关闭WARP功能，再执行安装WARP脚本。

- **八、启动并开机自启WARP功能：**

作用：永久关闭WARP功能后的再次启用。

因WARP脚本默认集成该功能，所以脚本安装成功后不必再执行该项。

- **九、代理协议脚本选择**

支持IPV4/IPV6/X86/ARM的全面脚本 ，推荐！
mack-a脚本地址：https://github.com/mack-a/v2ray-agent

支持IPV4/IPV6/X86的脚本
phlinhng脚本地址：https://github.com/phlinhng/v2ray-tcp-tls-web

如有好的脚本会继续添加，欢迎大家推荐哦！！

注意：域名解析所填写的IP必须是VPS本地IP，与WARP分配的IP没关系！

- **十、重启VPS实例（俗话说：重启解决99%的问题）**
 
甲骨文云也可以登录网页，进入实例后台，执行“重新引导”，在后台重启。

------------------------------------------------------------------------------------------------------
### 自定义ip分流配置模板说明

分流配置文件：outbounds配置文件或者routing配置文件，让IP、域名自定义。大家可根据代理脚本作者说明来查找文件路径！

```
{ 
"outbounds": [
    {
      "tag":"IP4-out",
      "protocol": "freedom",
      "settings": {}
    },
    {
      "tag":"IP6-out",
      "protocol": "freedom",
      "settings": {
        "domainStrategy": "UseIPv6" 
      }
    }
  ],
  "routing": {
    "rules": [
      {
        "type": "field",
        "outboundTag": "IP4-out",
        "domain": [""] 
      },
      {
        "type": "field",
        "outboundTag": "IP6-out",
        "network": "udp,tcp" 
      }
    ]
  }
}
```

outbounds部分："domainStrategy"后是"UseIPv6"还是"UseIPv4"？？

比如 纯v6添加虚拟4：UseIPv4。添加双栈V4+V6：UseIPv6

比如 纯v4添加虚拟6：UseIPv6。添加双栈V4+V6：UseIPv6

比如 双栈添加虚拟6：UseIPv6。双栈添加虚拟4：UseIPv4。双栈添加虚拟双栈V4+V6：UseIPv6

比如 双栈直接分流：UseIPv4

routing部分：设置自由度太高啦！可参考IP、域名自定义德鸡IPV6教程：待发布

----------------------------------------------------------------------------------------------

### 相关附加说明

- 提示：配置文件wgcf.conf和注册文件wgcf-account.toml都已备份在/etc/wireguard目录下！

- 查看WARP当前统计状态：wg

- 相关WARP进程命令

手动临时关闭WARP网络接口

wg-quick down wgcf

手动开启WARP网络接口

wg-quick up wgcf

启动systemctl enable wg-quick@wgcf

开始systemctl start wg-quick@wgcf

状态systemctl status wg-quick@wgcf

重启systemctl restart wg-quick@wgcf

停止systemctl stop wg-quick@wgcf

关闭systemctl disable wg-quick@wgcf


---------------------------------------------------------------------------------------------------------
#### 感谢P3terx大及原创者们，参考来源：

https://p3terx.com/archives/debian-linux-vps-server-wireguard-installation-tutorial.html

https://p3terx.com/archives/use-cloudflare-warp-to-add-extra-ipv4-or-ipv6-network-support-to-vps-servers-for-free.html

https://luotianyi.vc/5252.html

https://hiram.wang/cloudflare-wrap-vps/
