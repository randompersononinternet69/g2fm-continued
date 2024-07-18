# none of these options will work under EFI, the kernel is too old
menuentry "DSL"
    linux linux24 ramdisk_size=100000 init=/etc/init lang=us apm=power-off vga=791 nomce noapic quiet BOOT_IMAGE=knoppix
    initrd /boot/isolinux/minirt24.gz
}
menuentry "DSL Debug"
    linux linux24 ramdisk_size=100000 init=/etc/init lang=us apm=power-off vga=791 nomce noapic debug BOOT_IMAGE=knoppix
    initrd /boot/isolinux/minirt24.gz
}
menuentry "Install DSL"
    linux linux24 ramdisk_size=100000 init=/etc/init lang=us apm=power-off vga=791 nomce noapic debug BOOT_IMAGE=knoppix _install_
    initrd /boot/isolinux/minirt24.gz
}