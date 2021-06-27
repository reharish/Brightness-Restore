#!/bin/sh

bright=`cat /sys/class/backlight/amdgpu_bl0/brightness` 

if [ "$bright" ]
then
    echo $bright > /opt/essential/brightness-backup.txt
    #echo "works"
else
	exit 1
fi
