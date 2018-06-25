#!/bin/bash

set -x

# Partitionierung
DEVICE=/dev/sdb

# Partitionierung auf dem USB Stick löschen
dd if=/dev/zero of=$DEVICE bs=1M count=1

# Partitionen einrichten
fdisk ${DEVICE} <<EOT
n
p
1


t
c
a
w
EOT

# Formatierung, mounten des Laufwerks
mkfs.vfat -F32 ${DEVICE}1
mkdir -p /mnt/usb
mount ${DEVICE}1 /mnt/usb

# Kopieren der Daten
mkdir -p Win10
mount -o loop Win10_1803_German_x64.iso Win10
#cp -a Win10/* /mnt/usb
rsync -a -P Win10/* /mnt/usb
sync

# Aushängen der Laufwerke
umount /mnt/usb
umount Win10
