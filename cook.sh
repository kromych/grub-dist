#!/bin/bash

# Pre-cook the embeddable core grub image

# grub2-mkimage in Fedora
grub-mkimage -v -O i386-pc -p\(hd0,msdos1\)/boot/grub biosdisk part_msdos part_gpt acpi fat exfat ext2 video vbe multiboot2 normal relocator -o core.img

###################
# HISTORICAL NOTES:
###################

# Take the pre-cooked grub image made with `truncate --size 4M smth` after `grub-install smth`
#cp ../grub-dist/grub.img ./toyos.img
# and make it into a file used with the loop device.
#truncate ./toyos.img --size 128M

# Make grub image

#grub/usr/bin/grub-mkimage -v -O i386-pc -p\(hd0,msdos1\)/boot/grub biosdisk part_msdos fat exfat ext2 -o core.img

# Install grub with 'sudo grub-install --target=i386-pc ${LODEV}'
# and using 'grub-mkconfig -o /mnt/target/boot/grub/grub.cfg' would make
# grub generate a cinfiguration files for the system we are building on

#grub/usr/sbin/grub-bios-setup -d . -b ./boot.img -c ./core.img ${LODEV}

#dd if=grub/i386-pc/grub-core/boot.img of=$LODEV bs=446 count=1 seek=0 # 446 bytes only not to override partition data
#dd if=./core.img of=$LODEV bs=512 seek=1 # seek=1 to skip MBR


# Copying modules is not sufficient, grub puts some additional files

#Fedora
#grub2-install --target=i386-pc --boot-directory ${TARGET}/boot $LODEV
#grub2-install --target=x86_64-efi --efi-directory=${TARGET} --no-nvram --removable

#Ubuntu
#grub-install --target=i386-pc --boot-directory ${TARGET}/boot $LODEV
#grub-install --target=x86_64-efi --efi-directory=${TARGET} --no-nvram --removable

# cp -r /usr/lib/grub ${TARGET}/boot

#grub-mkstandalone -O x86_64-efi -o BOOTX64.EFI
