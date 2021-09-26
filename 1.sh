#!/usr/bin/env bash

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

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
if [ $release = "Centos" ]; then  
yum install vixie-cron crontabs
chkconfig crond on
service crond start
sed -i '/reboot/d' /var/spool/cron/root >/dev/null 2>&1
echo "0 3 * * * /sbin/reboot >/dev/null 2>&1" >> /var/spool/cron/root
chmod 777 /var/spool/cron/root
crontab /var/spool/cron/root
service crond restart
fi

if [ $release = "Debian" || $release = "Ubuntu" ]; then
apt install cron
sed -i '/reboot/d' /var/spool/cron/crontabs/root >/dev/null 2>&1
echo "0 3 * * * /sbin/reboot >/dev/null 2>&1" >> /var/spool/cron/crontabs/root
chmod 777 /var/spool/cron/crontabs/root
crontab /var/spool/cron/crontabs/root
service cron restart
fi
