if file --is-x86-linux "${grubfm_file}";
then
  menuentry $"Boot Linux Kernel" --class gnu-linux {
    if [ "$grub_platform" = "efi" ];
    then
      linuxefi "${grubfm_file}";
    else
      linux "${grubfm_file}";
    fi;
  }
fi;

if file --is-x86-linux "${grubfm_file}";
then
  menuentry $"Boot Linux Kernel with initrd" --class gnu-linux {
    initrd_list=("initrd.img-*" "initrd-*img")
    for initrd in "${initrd_list[@]}"; do
      if [ -f "${grubfm_file%/*}/${initrd}" ]; then
        initrd_file="${grubfm_file%/*}/${initrd}"
        break
      fi
    done

    if [ "$grub_platform" = "efi" ];
    then
      linuxefi "${grubfm_file}" "${initrd_file}";
    else
      linux "${grubfm_file}" "${initrd_file}";
    fi;
  }
fi;

if file --is-x86-multiboot "${grubfm_file}";
then
  menuentry $"Boot Multiboot Kernel" --class exe {
    set root="${grubfm_device}";
    multiboot "${grubfm_file}";
  }
fi;

if file --is-x86-multiboot2 "${grubfm_file}";
then
  menuentry $"Boot Multiboot2 Kernel" --class exe {
    multiboot2 "${grubfm_file}";
  }
fi;

if file --is-x86-bios-bootsector "${grubfm_file}";
then
  menuentry $"Chainload BIOS Boot Sector" --class exe {
    echo "Booting ${grubfm_file}"
    chainloader --force "${grubfm_file}";
  }
fi;
