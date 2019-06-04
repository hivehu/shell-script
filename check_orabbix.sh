#!/bin/bash
time=`/bin/date '+%F %T'`
ps -ef | grep orabbix | grep -v grep > /dev/null
if [ $? -eq 0 ]
then
        echo -e "\n$time"
        echo "the orabbix is running"
        exit 0
else
        echo -e "\n$time"
        echo "the orabbix is dead"
        /opt/orabbix/init.d/orabbix start &
fi
