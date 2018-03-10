#!/bin/bash
#

set -ex

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    sudo $0 $1 $2 $3 $4
    exit 0
fi

if [ "change" == "$1" ]; then

    efibootmgr -o $2,$3
    echo "die Bootreihenfolge auf die Einträge Boot$2 und dann Boot$3 eingestellt!!!"

elif [ "bootnext" == "$1" ]; then

    efibootmgr --bootnext $2
    echo "Der Bootloader für den nächsten Systemstart, einmalig auf den Eintrag zu Boot$2 umgestellt!!!"

elif [ "delete" == "$1" ]; then

    efibootmgr -b $2 -B
    echo "Booteintrag Boot$2 wurde gelöscht!!!"

elif [ "create" == "$1" ]; then

    if [ "ubuntu" == "$2" ]; then

        efibootmgr --create --disk $3 --part 1 --label "$4" --loader $5

    elif [ "arch1" == "$2" ]; then

        efibootmgr -c -d $3 -p 1 -l $4 -L "$5"

    elif [ "arch2" == "$2" ]; then

        efibootmgr -c -d $3 -p 1 -l $4 -L "$5" -u "$6"

    fi

    echo "Bootloader wurde umprogrammiert!!!"

else

    efibootmgr --verbose
    echo "./uefi-boot.sh change/bootnext/delete/create GUIDs"
    echo "./uefi-boot.sh create ubuntu/arch disk loader label"
    echo "./uefi-boot.sh create ubuntu /dev/sda \\EFI\\ubuntu\\grubx64.efi GRUB2"
    echo "./uefi-boot.sh create arch1 /dev/sda /EFI/systemd/systemd-bootx64.efi \"Linux Boot Manager\""
    echo "./uefi-boot.sh create arch2 /dev/sda \vmlinuz-linux \"Arch Linux efistub\" \"initrd=/initramfs-linux.img root=${tobootdevice} rw\""

fi
