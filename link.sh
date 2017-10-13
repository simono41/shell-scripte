#!/system/xbin/bash

BEFEHL=$1

mount -o rw,remount /system
ln -s /data/data/com.termux/files/usr/bin/$BEFEHL /system/xbin/
