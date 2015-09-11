#!/bin/sh

rm rootfs.img
rm ~/tftproot/rootfs.img
mkfs.cramfs  rootfs/ rootfs.img
#mkcramfs  rootfs/ rootfs.img
cp rootfs.img ~/tftproot/rootfs.img
ls -l ~/tftproot/rootfs.img
