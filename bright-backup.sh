#!/bin/sh

. /opt/Bright-Res/Bright-Res.rc

c_bright=`cat /sys/class/backlight/$BRIGHT_RES_DRIVER/brightness`

if [ "$c_bright" != "" ]
then
    echo $c_bright | tee /opt/Bright-Res/brightness.bak > /dev/null
else
    echo "Couldn't take Brightness backup"
fi
