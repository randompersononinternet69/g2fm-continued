# recover Windows from vhd using ntboot grub2 module - using snippet - no linux

echo "Recovering Windows from vhd..."
set lang=en_US;
terminal_output console;
loopback wimboot ${prefix}/wimboot.xz;
ntboot --efi=(wimboot)/bootmgfw.efi "(${2})/Recovery/WindowsRE/winre.wim";



