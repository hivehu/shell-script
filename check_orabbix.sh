#!/bin/bash
time=`/bin/date '+%F %T'`
#n=`ps -ef | grep orabbix | grep -v grep | wc -l
echo -e "\n$time"
/usr/bin/ps -ef | /usr/bin/grep orabbix | /usr/bin/grep -v 'grep' > /dev/null
if [ $? -eq 0 ]
then
#        echo -e "\n$time"
        echo "the orabbix is running"
#       /opt/orabbix/init.d/orabbix start &
        exit 0
else
#        echo -e "\n$time"
        echo "the orabbix is dead"
        /opt/orabbix/init.d/orabbix start &
fi
