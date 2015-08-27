#!/bin/bash
# =============================================================
# Author     : QiuWeibo
# Date       : 2015.8.4
# Version    : V1.0.0
# Comment    : format mmc
#          1.Support format mmc

MMC_PARTITION=/dev/mmcblk0p1
MOUNT_MMC_PATH=/media/mmcblk0p1

# if mmc partition is exist , just return
if [ -e "$MMC_PARTITION" ] ; then
	echo "$MMC_PARTITION exist!"
	exit
fi

# use fdisk command to partition mmc
fdisk /dev/mmcblk0 << EOF
n
p
1


w
EOF

# format partition as ext3 type
mkfs.ext3 $MMC_PARTITION

# mount 
if [ ! -e "$MOUNT_MMC_PATH" ] ; then
	mkdir $MOUNT_MMC_PATH
fi
mount $MMC_PARTITION $MOUNT_MMC_PATH

echo "$MMC_PARTITION success!"

