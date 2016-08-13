#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

#重启squid
squid -k kill >> /ifuboy/sh/log/sprotect.log
service squid start >> /ifuboy/sh/log/protect.log

#重启mproxy
ps -ef | grep mproxy | grep -v grep | cut -c 9-15 | xargs kill -s 9
cd /ifuboy
./mproxy -l 8080 -d >> /ifuboy/sh/log/protect.log

#重启radiusd
service radiusd  restart

#开启路由转发
echo "1" > /proc/sys/net/ipv4/ip_forward
