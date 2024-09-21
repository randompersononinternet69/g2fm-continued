menuentry $"Android-x86 Live" --class android{
    set kcmdline="root=/dev/ram0";
    linux $vmlinuz_img $kcmdline $android_selinux $android_hardware $linux_extra $android_install;
    initrd $initrd_img;
}
if [ "${android_selinux}" = " " ]; then
    menuentry "[ ] androidboot.selinux=permissive" --class settings{
        export android_selinux="androidboot.selinux=permissive";
        configfile ${prefix}/distro/andmenu.sh
    }
else
    menuentry "[+] androidboot.selinux=permissive" --class settings{
        export android_selinux=" ";
        configfile ${prefix}/distro/andmenu.sh;
    }
fi;
if [ "${android_install}" = " " ]; then
    menuentry "[ ] Install Android" --class settings{
        export android_install="INSTALL=1";
        configfile ${prefix}/distro/andmenu.sh
    }
else
    menuentry "[+] Install Android" --class settings{
        export android_install=" ";
        configfile ${prefix}/distro/andmenu.sh;
    }
fi;
if [ "${android_hardware}" = " " ]; then
    menuentry "[ ] androidboot.hardware=android_x86" --class settings{
        export android_hardware="androidboot.hardware=android_x86";
        configfile ${prefix}/distro/andmenu.sh
    }
else
    menuentry "[+] androidboot.hardware=android_x86" --class settings{
        export android_hardware=" ";
        configfile ${prefix}/distro/andmenu.sh;
    }
fi;
if [ "${vulkan}" = " " ]; then
    menuentry "[ ] Vulkan support (experimental)" --class settings{
        export vulkan="VULKAN=1";
        configfile ${prefix}/distro/andmenu.sh
    }
else
    menuentry "[+] Vulkan support (experimental)" --class settings{
        export vulkan=" ";
        configfile ${prefix}/distro/andmenu.sh;
    }
fi;

if [ "${setupwizard}" = " " ]; then
    menuentry "[ ] No Setup Wizard" --class settings{
        export setupwizard="SETUPWIZARD=0";
        configfile ${prefix}/distro/andmenu.sh
    }
else
    menuentry "[+] No Setup Wizard" --class settings{
        export setupwizard=" ";
        configfile ${prefix}/distro/andmenu.sh;
    }
fi;

if [ "${hwaccel}" = " " ]; then
    menuentry "[ ] No Hardware Acceleration" --class settings{
        export hwaccel="nomodeset HWACCEL=0";
        configfile ${prefix}/distro/andmenu.sh
    }
else
    menuentry "[+] No Hardware Acceleration" --class settings{
        export hwaccel=" ";
        configfile ${prefix}/distro/andmenu.sh;
    }
fi;

if [ "${acpi}" = " " ]; then
    menuentry "[ ] No ACPI and no setup wizard" --class settings{
        export acpi="acpi=off SETUPWIZARD=0";
        configfile ${prefix}/distro/andmenu.sh
    }
else
    menuentry "[+] No ACPI and no setup wizard" --class settings{
        export acpi=" ";
        configfile ${prefix}/distro/andmenu.sh;
    }
fi;

if [ -s ($android)$kdir/install.img ]; then
    if [ "${autoinstall}" = " " ]; then
        menuentry "[ ] Auto Install to specified harddisk" --class settings{
            export autoinstall="AUTO_INSTALL=0";
            configfile ${prefix}/distro/andmenu.sh
        }
    else
        menuentry "[+] Auto Install to specified harddisk" --class settings{
            export autoinstall=" ";
            configfile ${prefix}/distro/andmenu.sh;
        }
    fi;

    if [ "${autoupdate}" = " " ]; then
        menuentry "[ ] Auto Update" --class settings{
            export autoupdate="AUTO_INSTALL=update";
            configfile ${prefix}/distro/andmenu.sh
        }
    else
        menuentry "[+] Auto Update" --class settings{
            export autoupdate=" ";
            configfile ${prefix}/distro/andmenu.sh;
        }
    fi;
fi;