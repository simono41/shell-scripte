xorriso -as mkisofs \
-iso-level 3 \
-full-iso9660-filenames \
-volid "SIMON_LINUX" \
-eltorito-boot isolinux/isolinux.bin \
-eltorito\-catalog isolinux/boot.cat \
-no-emul-boot -boot-load-size 4 -boot-info-table \
-isohybrid-mbr /mnt/customiso/arch/isolinux/isohdpfx.bin \
-output arch-simon-linux-$(date "+%y.%m.%d")-x86_64.iso arch
