#!/system/xbin/bash

BEFEHL=$1

if [ -f /system/xbin/$BEFEHL ]; then
  echo "Überschreibe /system/xbin/$BEFEHL"
  rm /system/xbin/$BEFEHL
fi

mount -o rw,remount /system
ln -s /data/data/com.termux/files/usr/bin/$BEFEHL /system/xbin/
