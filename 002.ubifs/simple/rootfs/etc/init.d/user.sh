#!/bin/sh
# Add by QWB 2014.5.21 for aPM.MCU

# Add by QWB 2014.5.20 for QT Start
export QTDIR=/opt/Qt:$QTDIR
export LD_LIBRARY_PATH=/opt/Qt/lib/
export QT_QWS_FONTDIR=/opt/Qt/lib/fonts
# Add by QWB 2014.5.20 for QT End

# Add by QWB 2014.5.20 for Tslib Start
export T_ROOT=/opt/tslib/
export LD_LIBRARY_PATH=/opt/tslib/lib/:$LD_LIBRARY_PATH
export TSLIB_CONSOLEDEVICE=none
export TSLIB_FBDEVICE=/dev/fb0
export TSLIB_TSDEVICE=/dev/input/event0 
export TSLIB_PLUGINDIR=$T_ROOT/lib/ts
export TSLIB_CONFFILE=$T_ROOT/etc/ts.conf
export POINTERCAL_FILE=/etc/pointercal
export TSLIB_CALIBFILE=/etc/pointercal

#umount follow support touchscreen
export QWS_MOUSE_PROTO=tslib:/dev/input/event0

#umount follow support mouse
#export QWS_MOUSE_PROTO=MouseMan:/dev/input/mice

#umoun tfollow support both touchscreen and mouse
#export set QWS_MOUSE_PROTO="TSLIB:/dev/input/event0 Intellimouse:/dev/input/mice"

#if file exit
if [ ! -e "$POINTERCAL_FILE" ];then
	echo "$POINTERCAL_FILE is not exist!"
	touch "$POINTERCAL_FILE"
	/opt/tslib/bin/ts_calibrate
else
	echo "$POINTERCAL_FILE exist!"
fi
# Add by QWB 2014.5.20 for Tslib End

if [ ! -e "/var/volatile/run/InitFinishTag" ];then
#Add by QWB 20141112 :/dev/rtc for "hwclock -s"
        rm -f /dev/rtc
        ln -s /dev/rtc1 /dev/rtc
	mkdir -p /var/volatile/cache/
	mkdir -p /var/volatile/lock/
	mkdir -p /var/volatile/log/
	mkdir -p /var/volatile/run/
	mkdir -p /var/volatile/log/
	mkdir -p /var/volatile/run/
	mkdir -p /var/volatile/tmp/
	touch /var/volatile/run/InitFinishTag
	ifconfig eth0 192.168.1.110 netmask 255.255.255.0
	ifconfig lo 127.0.0.1 up
fi

# Add by QWB for monitor running Start
SEECARE_APP=/mnt/userfs/Monitor
MONITOR_RUN_TAG=/var/volatile/run/monitor
if [ -e "$SEECARE_APP" ] && [ ! -e "$MONITOR_RUN_TAG" ];then
	echo "$SEECARE_APP Running!"
	touch $MONITOR_RUN_TAG
	$SEECARE_APP -qws &
else
	echo "$SEECARE_APP have Run already!"
fi
# Add by QWB for monitor running End
