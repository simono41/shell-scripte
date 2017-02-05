mkdir work/iso
mkdir work/iso/isolinux
mkdir work/iso/arch
mkdir work/iso/arch/boot
mkdir work/iso/arch/x86_64
mkdir work/iso/arch/boot/x86_64
mkdir work/iso/arch/boot/syslinux

cp -R work/airootfs/usr/lib/syslinux/bios/* work/iso/arch/boot/syslinux/
cp work/airootfs/boot/initramfs-linux.img work/iso/arch/boot/x86_64/
cp work/airootfs/boot/initramfs-linux-fallback.img work/iso/arch/boot/x86_64/
cp work/airootfs/boot/vmlinuz-linux work/iso/arch/boot/x86_64/

arch-chroot work/airootfs LANG=C pacman -Sl | awk '/\[installed\]$/ {print $1 "/" $2 "-" $3}' > /pkglist.txt
cp work/airootfs/pkglist.txt work/iso/arch/boot/x86_64/
arch-chroot work/airootfs pacman -Scc
mksquashfs work/airootfs work/iso/arch/x86_64/airootfs.sfs
md5sum work/iso/arch/x86_64/airootfs.sfs > work/iso/arch/x86_64/airootfs.md5

echo "DEFAULT menu.c32" > work/iso/arch/boot/syslinux/syslinux.cfg
echo "PROMPT 0" >> work/iso/arch/boot/syslinux/syslinux.cfg
echo "MENU TITLE Simon Linux" >> work/iso/arch/boot/syslinux/syslinux.cfg
echo "TIMEOUT 300" >> work/iso/arch/boot/syslinux/syslinux.cfg
echo "" >> work/iso/arch/boot/syslinux/syslinux.cfg
echo "LABEL arch" >> work/iso/arch/boot/syslinux/syslinux.cfg
echo "MENU LABEL Simon Linux" >> work/iso/arch/boot/syslinux/syslinux.cfg
echo "LINUX ../x86_64/vmlinuz-linux" >> work/iso/arch/boot/syslinux/syslinux.cfg
echo "INITRD ../x86_64/initramfs-linux-fallback.img" >> work/iso/arch/boot/syslinux/syslinux.cfg
echo "APPEND archisolabel=SIMON_LINUX" >> work/iso/arch/boot/syslinux/syslinux.cfg
echo "" >> work/iso/arch/boot/syslinux/syslinux.cfg
echo "ONTIMEOUT arch" >> work/iso/arch/boot/syslinux/syslinux.cfg

echo "DEFAULT loadconfig" > work/iso/isolinux/isolinux.cfg
echo "" >> work/iso/isolinux/isolinux.cfg
echo "LABEL loadconfig" >> work/iso/isolinux/isolinux.cfg
echo "  CONFIG /arch/boot/syslinux/syslinux.cfg" >> work/iso/isolinux/isolinux.cfg
echo "  APPEND /arch/boot/syslinux/" >> work/iso/isolinux/isolinux.cfg

read -p "Soll das Image jetzt gemacht werden? [Y/n] " image

if [ "$root" != "n" ]
  then
  mkdir out
xorriso -as mkisofs \
-iso-level 3 \
-full-iso9660-filenames \
-volid "SIMON_LINUX" \
-eltorito-boot work/iso/isolinux/isolinux.bin \
-eltorito\-catalog work/iso/isolinux/boot.cat \
-no-emul-boot -boot-load-size 4 -boot-info-table \
-isohybrid-mbr $(pwd)/iso/arch/isolinux/isohdpfx.bin \
-output out/arch-simon-linux-$(date "+%y.%m.%d")-x86_64.iso arch
fi
