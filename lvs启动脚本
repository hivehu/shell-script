#!/bin/bash
#此脚本为lvs启动脚本
. /etc/profile
. /etc/init.d/functions
VIP=172.31.11.127
LVSPORT=80
RSPORT=80
RIP=(
        172.31.11.125
        172.31.11.126
                        )
ifth=`ifconfig | sed '2,$d' | cut -d: -f1`

start(){
        ifconfig $ifth:`echo $VIP | cut -d. -f4` $VIP/24 up      ##绑定VIP
        route add -host $VIP dev $ifth  ##添加路由
        ipvsadm -C
        ipvsadm --set 8 10 30           ##设置TCP,TCPFIN,UDP超时时间
        ipvsadm -A -t $VIP:$LVSPORT -s wrr
        for (( i=0;i<${#RIP[*]};i++))   ##${#RIP[*]}为数组元素个数
        do
                ipvsadm -a -t $VIP:$LVSPORT -r ${RIP[$i]}:$RSPORT -g -w 1
        done
        if [ $? -eq 0 ]
        then
                echo "LVS ls running"
        else
                echo "start falied"
                exit 1
        fi
}

stop(){
        ipvsadm -C
        route del -host $VIP
        ifconfig $ifth:`echo $VIP | cut -d. -f4` down
        if [ $? -eq 0 ]
        then
                echo "LVS ls stopd"
        else
                echo "stop falied"
                exit 1
        fi
}

case "$1" in
        start)
                start
                ;;
        stop)
                stop
                ;;
        restart)
                stop
                start
                ;;
        *)
                echo "USAGE:$0 {start|stop|restart}"
                ;;
esac
