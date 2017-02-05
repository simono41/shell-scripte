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

mksquashfs airootfs /arch/x86_64/airootfs.sfs
