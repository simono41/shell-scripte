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
mksquashfs work/airootfs work/arch/x86_64/airootfs.sfs
md5sum work/arch/x86_64/airootfs.sfs > work/arch/x86_64/airootfs.md5

read -p "Soll das Image jetzt gemacht werden? [Y/n] " image

if [ "$root" != "n" ]
  then
  mkdir out
  cd work
xorriso -as mkisofs \
-iso-level 3 \
-full-iso9660-filenames \
-volid "SIMON_LINUX" \
-eltorito-boot isolinux/isolinux.bin \
-eltorito\-catalog isolinux/boot.cat \
-no-emul-boot -boot-load-size 4 -boot-info-table \
-isohybrid-mbr $(pwd)/arch/isolinux/isohdpfx.bin \
-output ../out/arch-simon-linux-$(date "+%y.%m.%d")-x86_64.iso arch
fi
