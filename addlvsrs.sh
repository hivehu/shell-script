#!/bin/bash
. /etc/profile
. /etc/init.d/functions
VIP=(
        172.31.11.127
        172.31.11.131
                        )

start(){
        for((i=0;i<${#VIP[*]};i++))
        do
                ifconfig lo:$i ${VIP[$i]} netmask 255.255.255.255 up
                route add -host ${VIP[$i]} dev lo:$i
        done
        echo "1" > /proc/sys/net/ipv4/conf/ens160/arp_ignore
        echo "1" > /proc/sys/net/ipv4/conf/all/arp_ignore
        echo "2" > /proc/sys/net/ipv4/conf/ens160/arp_announce
        echo "2" > /proc/sys/net/ipv4/conf/all/arp_announce
}

stop(){
        for((i=0;i<${#VIP[*]};i++))
        do
                ifconfig lo:$i ${VIP[$i]}/32 down
                route del -host ${VIP[$i]} dev lo:$i
        done
        echo "0" > /proc/sys/net/ipv4/conf/ens160/arp_ignore
        echo "0" > /proc/sys/net/ipv4/conf/all/arp_ignore
        echo "0" > /proc/sys/net/ipv4/conf/ens160/arp_announce
        echo "0" > /proc/sys/net/ipv4/conf/all/arp_announce
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
