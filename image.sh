genisoimage -l -r -J -V "ARCH_201701" -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -c isolinux/boot.cat -o output.iso arch
