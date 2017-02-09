#!/bin/bash

set -e -u

iso_name=SIMON_OS
iso_label="SIMON_OS"
iso_version=$(date +%Y.%m.%d)
work_dir=work
out_dir=out
install_dir=arch

pacstrap -i ${work_dir}/${install_dir} base base-devel syslinux efibootmgr

echo "Bitte fuer aenderungen jetzt abrechen!!!"
sleep 10

echo "HOOKS="base udev archiso sata filesystems"" > ${work_dir}/${install_dir}/etc/mkinitcpio.conf
echo "COMPRESSION="xz"" >> ${work_dir}/${install_dir}/etc/mkinitcpio.conf

arch-chroot ${work_dir}/airootfs mkinitcpio -p linux

# BIOS

mkdir ${work_dir}/iso
mkdir ${work_dir}/iso/isolinux
mkdir ${work_dir}/iso/arch
mkdir ${work_dir}/iso/arch/boot
mkdir ${work_dir}/iso/arch/x86_64
mkdir ${work_dir}/iso/arch/boot/x86_64
mkdir ${work_dir}/iso/arch/boot/syslinux

cp -R ${work_dir}/${install_dir}/usr/lib/syslinux/bios/* ${work_dir}iso/arch/boot/syslinux/
cp ${work_dir}/${install_dir}/boot/initramfs-linux.img ${work_dir}/iso/arch/boot/x86_64/
cp ${work_dir}/${install_dir}/boot/initramfs-linux-fallback.img w${work_dir}/iso/arch/boot/x86_64/
cp ${work_dir}/${install_dir}/boot/vmlinuz-linux ${work_dir}/iso/arch/boot/x86_64/
cp ${work_dir}/${install_dir}/usr/lib/syslinux/bios/isolinux.bin ${work_dir}/iso/isolinux/
cp ${work_dir}/${install_dir}/usr/lib/syslinux/bios/isohdpfx.bin ${work_dir}/iso/isolinux/
cp ${work_dir}/${install_dir}/usr/lib/syslinux/bios/ldlinux.c32 ${work_dir}/iso/isolinux/

arch-chroot ${work_dir}/${install_dir} LANG=C pacman -Sl | awk '/\[installed\]$/ {print $1 "/" $2 "-" $3}' > /pkglist.txt
cp ${work_dir}/${install_dir}/pkglist.txt ${work_dir}/iso/arch/x86_64/
arch-chroot ${work_dir}/${install_dir} pacman -Scc
mksquashfs ${work_dir}/${install_dir} ${work_dir}/iso/arch/x86_64/airootfs.sfs -noappend -comp xz
md5sum ${work_dir}/iso/arch/x86_64/airootfs.sfs > ${work_dir}/iso/arch/x86_64/airootfs.md5

echo "DEFAULT menu.c32" > ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg
echo "PROMPT 0" >> ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg
echo "MENU TITLE ${iso_name}" >> ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg
echo "TIMEOUT 300" >> ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg
echo "" >> ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg
echo "LABEL arch" >> ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg
echo "MENU LABEL ${iso_name}" >> ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg
echo "LINUX ../x86_64/vmlinuz-linux" >> ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg
echo "INITRD ../x86_64/initramfs-linux-fallback.img" >> ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg
echo "APPEND archisolabel=${iso_name}" >> ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg
echo "" >> ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg
echo "ONTIMEOUT arch" >> ${work_dir}/iso/arch/boot/syslinux/syslinux.cfg

echo "DEFAULT loadconfig" > ${work_dir}/iso/isolinux/isolinux.cfg
echo "" >> ${work_dir}/iso/isolinux/isolinux.cfg
echo "LABEL loadconfig" >> ${work_dir}/iso/isolinux/isolinux.cfg
echo "  CONFIG /arch/boot/syslinux/syslinux.cfg" >> ${work_dir}/iso/isolinux/isolinux.cfg
echo "  APPEND /arch/boot/syslinux/" >> ${work_dir}/iso/isolinux/isolinux.cfg

# EFI

mkdir -p  ${work_dir}/iso/EFI
mkdir -p ${work_dir}/iso/EFI/archiso
truncate -s 64M ${work_dir}/iso/EFI/archiso/efiboot.img
mkfs.fat -n ARCHISO_EFI ${work_dir}/iso/EFI/archiso/efiboot.img

mkdir -p ${work_dir}/efiboot
mount ${work_dir}/iso/EFI/archiso/efiboot.img ${work_dir}/efiboot

mkdir -p ${work_dir}/efiboot/EFI/archiso
cp ${work_dir}/iso/${install_dir}/boot/x86_64/vmlinuz ${work_dir}/efiboot/EFI/archiso/vmlinuz.efi
cp ${work_dir}/iso/${install_dir}/boot/x86_64/archiso.img ${work_dir}/efiboot/EFI/archiso/archiso.img

cp ${work_dir}/iso/${install_dir}/boot/intel_ucode.img ${work_dir}/efiboot/EFI/archiso/intel_ucode.img

mkdir -p ${work_dir}/efiboot/EFI/boot
cp ${work_dir}/x86_64/airootfs/usr/share/efitools/efi/PreLoader.efi ${work_dir}/efiboot/EFI/boot/bootx64.efi

cp ${work_dir}/x86_64/airootfs/usr/share/efitools/efi/HashTool.efi ${work_dir}/efiboot/EFI/boot/

cp ${work_dir}/x86_64/airootfs/usr/lib/systemd/boot/efi/systemd-bootx64.efi ${work_dir}/efiboot/EFI/boot/loader.efi
mkdir -p ${work_dir}/efiboot/loader/entries
cp ${script_path}/efiboot/loader/loader.conf ${work_dir}/efiboot/loader/
cp ${script_path}/efiboot/loader/entries/uefi-shell-v2-x86_64.conf ${work_dir}/efiboot/loader/entries/
cp ${script_path}/efiboot/loader/entries/uefi-shell-v1-x86_64.conf ${work_dir}/efiboot/loader/entries/

curl -o ./archiso-x86_64-cd.conf https://raw.githubusercontent.com/simono41/archiso/master/configs/releng/efiboot/loader/entries/archiso-x86_64-cd.conf

sed "s|%ARCHISO_LABEL%|${iso_label}|g;
s|%INSTALL_DIR%|${install_dir}|g" \
archiso-x86_64-cd.conf > ${work_dir}/efiboot/loader/entries/archiso-x86_64.conf

cp ${work_dir}/iso/EFI/shellx64_v2.efi ${work_dir}/efiboot/EFI/
cp ${work_dir}/iso/EFI/shellx64_v1.efi ${work_dir}/efiboot/EFI/
umount -d ${work_dir}/efiboot

mkdir -p ${work_dir}/iso/EFI/boot
cp ${work_dir}/x86_64/airootfs/usr/share/efitools/efi/PreLoader.efi ${work_dir}/iso/EFI/boot/bootx64.efi
cp ${work_dir}/x86_64/airootfs/usr/share/efitools/efi/HashTool.efi ${work_dir}/iso/EFI/boot/

cp ${work_dir}/x86_64/airootfs/usr/lib/systemd/boot/efi/systemd-bootx64.efi ${work_dir}/iso/EFI/boot/loader.efi

mkdir -p ${work_dir}/iso/loader/entries
cp ${script_path}/efiboot/loader/loader.conf ${work_dir}/iso/loader/
cp ${script_path}/efiboot/loader/entries/uefi-shell-v2-x86_64.conf ${work_dir}/iso/loader/entries/
cp ${script_path}/efiboot/loader/entries/uefi-shell-v1-x86_64.conf ${work_dir}/iso/loader/entries/

curl -o ./archiso-x86_64-usb.conf https://raw.githubusercontent.com/simono41/archiso/master/configs/releng/efiboot/loader/entries/archiso-x86_64-usb.conf

sed "s|%ARCHISO_LABEL%|${iso_label}|g;
s|%INSTALL_DIR%|${install_dir}|g" \
archiso-x86_64-usb.conf > ${work_dir}/iso/loader/entries/archiso-x86_64.conf

# EFI Shell 2.0 for UEFI 2.3+
curl -o ${work_dir}/iso/EFI/shellx64_v2.efi https://raw.githubusercontent.com/tianocore/edk2/master/ShellBinPkg/UefiShell/X64/Shell.efi
# EFI Shell 1.0 for non UEFI 2.3+
curl -o ${work_dir}/iso/EFI/shellx64_v1.efi https://raw.githubusercontent.com/tianocore/edk2/master/EdkShellBinPkg/FullShell/X64/Shell_Full.efi

curl -o ${work_dir}/iso/loader/entries/uefi-shell-v1-x86_64.conf https://raw.githubusercontent.com/simono41/archiso/master/configs/releng/efiboot/loader/entries/uefi-shell-v1-x86_64.conf

curl -o ${work_dir}/iso/loader/entries/uefi-shell-v2-x86_64.conf https://raw.githubusercontent.com/simono41/archiso/master/configs/releng/efiboot/loader/entries/uefi-shell-v2-x86_64.conf

curl -o ${work_dir}/iso/loader/loader.conf https://raw.githubusercontent.com/simono41/archiso/master/configs/releng/efiboot/loader/loader.conf

read -p "Soll das Image jetzt gemacht werden? [Y/n] " image

if [ "$image" != "n" ]
  then
  mkdir out
xorriso -as mkisofs \
-iso-level 3 \
-full-iso9660-filenames \
-volid "${iso_label}" \
-eltorito-boot isolinux/isolinux.bin \
-eltorito\-catalog isolinux/boot.cat \
-no-emul-boot -boot-load-size 4 -boot-info-table \
-isohybrid-mbr $(pwd)/${work_dir}/iso/isolinux/isohdpfx.bin \
-output ${out_dir}/arch-${iso_label}-$(date "+%y.%m.%d")-x86_64.iso ${work_dir}/iso/
fi
