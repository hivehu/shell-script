#!/bin/bash
#该脚本用来检测lvs服务的可用性
. /etc/profile
VIP=172.31.11.127
while ((1))
do
        /usr/bin/ping -c 2 $VIP > /dev/null
        if [ $? -eq 0 ]
        then
                sleep 2
                continue
        else
                /root/script/addlvs.sh start
                break
        fi
done
