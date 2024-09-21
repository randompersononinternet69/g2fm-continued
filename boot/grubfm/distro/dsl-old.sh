# none of these options will work under EFI, the kernel is too old
menuentry "DSL"
    echo "Loading DSL"
    linux linux24 ramdisk_size=100000 init=/etc/init lang=us apm=power-off vga=791 nomce noapic quiet BOOT_IMAGE=knoppix
    echo "Loading minirt24.gz"
    initrd /boot/isolinux/minirt24.gz
}

menuentry "DSL Debug"
    echo "Loading DSL Debug"
    linux linux24 ramdisk_size=100000 init=/etc/init lang=us apm=power-off vga=791 nomce noapic debug BOOT_IMAGE=knoppix
    echo "Loading minirt24.gz"
    initrd /boot/isolinux/minirt24.gz
}

menuentry "Install DSL"
    echo "Loading Install DSL"
    linux linux24 ramdisk_size=100000 init=/etc/init lang=us apm=power-off vga=791 nomce noapic debug BOOT_IMAGE=knoppix _install_
    echo "Loading minirt24.gz"
    initrd /boot/isolinux/minirt24.gz
}

