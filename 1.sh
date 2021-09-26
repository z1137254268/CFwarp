#!/usr/bin/env bash

systemctl restart wg-quick@wgcf
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
systemctl enable wg-quick@wgcf >/dev/null 2>&1
