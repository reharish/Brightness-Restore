#!/bin/bash

# Code : Brightness Restore for Xfce4
# Author : reharish, whitedot
# Description : The Script used to resolve brightness restoring issue mainly in kali-linux, ubuntu-mate and other OS using Xfce4 and old bios.
# Working : This Script creates a service which will keep log of your brightness when you shutdown and restore it when you login again

ChooseGraphic()
{
	echo -n "Searching Graphics Drivers."
	gra=`ls /sys/class/backlight`
	echo " ~ done"
	count=${#gra[@]} 
	echo $count found 
	for i in $gra;
	do
		read -p  "do you want to use $i (Y/n) : " Graphics
		if [ $Graphics == "Y" ];
		then
			echo -n "$i : selected as Preferred Graphics Driver"
			display=$i
			break
		else
			continue
		fi
	done
	echo 
	if [ "$display" ];
	then
		echo " ~ done "
	else
		echo "No Graphics detected"
		echo 
		echo "Run Again and Specify Graphics card"
		echo "Usage : sudo bash install amdgpu_bl0"
		exit 404
	fi

}

PermissionTest()
{
	#This function allows the code to test root priviledge
	mkdir /opt/Bri-Res &> /dev/null
	err_code=$?

	if [ $err_code -ge 1 ]
	then

		echo "ERROR :::: Run with Root Privileges"
		echo "run 'sudo bash install.sh'"
		exit 200
	fi
}

InstallerScript()
{
echo "++++++++Installing Service+++++++++"
if test -d /etc/systemd/system;
then
	cp bright-backup.service /etc/systemd/system/
	systemctl enable bright-backup.service
	err_code=$?
	if [ $err_code -gt 0 ]
	then
		"systemctl service not starting"
	fi
	echo -n "Realoading Systemctl Daemons.. "
	systemctl daemon-reload
	echo " Done "
fi
echo "++++++++Restore Part+++++++++"
echo "Creating Backup-Directory - /opt/Bri-Res"
mkdir /opt/Bri-Res
echo -n " ~ done "
echo "Setting Permission for Backup-Directory - /opt/Bri-Res"
chmod -R 777 /opt/Bri-Res
echo -n " ~ done "
echo "Copying Configuration script -> /opt/Bri-Res/"
if test -d /opt/Bri-Res;
then
	cp bright-backup.sh /opt/Bri-Res/
	cp brightness /opt/Bri-Res/
	chmod -R 777 /opt/Bri-Res
	echo -n " ~ done "
else
	echo -n " ~  undone"
	echo "Error Creating Files"
fi
if test -d /etc/X11/Xsession.d;
then
	echo "Creating Restorer Script on /etc/X11/Xsession.d"
	if test -f /etc/X11/Xsession.d/99x11-common_start;
	then
		cp /etc/X11/Xsession.d/99x11-common_start /opt/Bri-Res/
		echo "cat /opt/Bri-Res/brightness > /sys/class/backlight/$display/brightness" > /etc/X11/Xsession.d/99x11-common_start
		echo "exec \$STARTUP" >> /etc/X11/Xsession.d/99x11-common_start
	else
		echo "error Creating file "
		echo "Seems you don't have 99x11-common_start file"
		exit 500
	fi
fi
}

Hooray(){
	#echo "🅱🆁🅸-🆁🅴🆂"
	echo "
██████╗░██████╗░██╗░░░░░░██████╗░███████╗░██████╗
██╔══██╗██╔══██╗██║░░░░░░██╔══██╗██╔════╝██╔════╝
██████╦╝██████╔╝██║█████╗██████╔╝█████╗░░╚█████╗░
██╔══██╗██╔══██╗██║╚════╝██╔══██╗██╔══╝░░░╚═══██╗
██████╦╝██║░░██║██║░░░░░░██║░░██║███████╗██████╔╝
╚═════╝░╚═╝░░╚═╝╚═╝░░░░░░╚═╝░░╚═╝╚══════╝╚═════╝░"
echo
echo
	PermissionTest
	ChooseGraphic
	InstallerScript
	echo
	echo "Installation Completed"

exit 0
}

# Trigger Point
Hooray