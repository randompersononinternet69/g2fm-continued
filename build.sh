#!/usr/bin/sh
if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root (EFI builds won't work if not run as root)"
  exit
fi
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
RESET='\033[0m' # No Color
echo "${CYAN}"-----------------------------------------
echo -n "${CYAN}Welcome to the G2FM builder!"
echo "${CYAN}"-----------------------------------------
echo
echo -n "${CYAN}---Installing packages...---".
sudo -E apt-get -y install gettext grub2-common genisoimage p7zip-full mtools xorriso wget
clear
sudo ./update_grub2.sh
clear
echo "${CYAN}Check for missing packages (everything should be found)"
echo -n "${CYAN}Checking for gettext... "
if [ "$(which msgfmt)" ]; then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease manually install gettext."
    exit
fi
echo -n "${CYAN}Checking for xorriso... "
if [ "$(which xorriso)" ]; then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease manually install xorriso."
    exit
fi
echo -n "${CYAN}Checking for grub... "
if [ "$(which grub-mkimage)" ]; then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease manually install grub."
    exit
fi
echo -n "${CYAN}Checking for mtools... "
if [ "$(which mtools)" ]; then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease manually install mtools."
    exit
fi

if [ -d "build" ]; then
    rm -r build
fi
mkdir build
clear
echo -n ${RESET}
clear
echo "${CYAN}---Making a copy of /boot to /build---"
cat /proc/sys/kernel/random/uuid >boot/grubfm/ver
cp -r boot build/ > /tmp/cp.log 2>&1
echo "Copy log located at /tmp/cp.log"
cp grub/locale/*.mo build/boot/grubfm/locale/ > /tmp/localecp.log 2>&1
echo "Locale copy log located at /tmp/localecp.log"
cd lang
for po in */fm.po; do
  msgfmt ${po} -o ../build/boot/grubfm/locale/fm/"${po%/*}".mo > /tmp/msgfmt.log 2>&1
done
cd ..
#clear

echo "Language"
echo "1. Simplified Chinese"
echo "2. Traditional Chinese"
echo "3. English (United States)"
echo "4. Turkish"
echo "5. German"
echo "6. Vietnamese"
echo "7. Russian"
echo "8. Hebrew"
echo "9. Spanish"
echo "10. Polish"
echo "11. Ukrainian"
echo "12. French"
echo "13. Danish"
echo "14. Portuguese (Brazil)"
echo "15. Arabic"
echo "16. Korean"
echo "17. Hungarian"
read -p "Please make a choice: " choice
case "$choice" in
    1)
        echo "zh_CN"
        cp lang/zh_TW/lang.sh build/boot/grubfm/
        ;;
    2)
        echo "zh_TW"
        cp lang/zh_TW/lang.sh build/boot/grubfm/
        ;;
    3)
        echo "en_US"
        ;;
    4)
        echo "tr_TR"
        cp lang/tr_TR/lang.sh build/boot/grubfm/
        ;;
    5)
        echo "de_DE"
        cp lang/de_DE/lang.sh build/boot/grubfm/
        ;;
    6)
        echo "vi_VN"
        cp lang/vi_VN/lang.sh build/boot/grubfm/
        ;;
    7)
        echo "ru_RU"
        cp lang/ru_RU/lang.sh build/boot/grubfm/
        ;;
    8)
        echo "he_IL"
        cp lang/he_IL/lang.sh build/boot/grubfm/
        ;;
    9)
        echo "es_ES"
        cp lang/es_ES/lang.sh build/boot/grubfm/
        ;;
    10)
        echo "pl_PL"
        cp lang/pl_PL/lang.sh build/boot/grubfm/
        ;;
    11)
        echo "uk_UA"
        cp lang/uk_UA/lang.sh build/boot/grubfm/
        ;;
    12)
        echo "fr_FR"
        cp lang/fr_FR/lang.sh build/boot/grubfm/
        ;;
    13)
        echo "da_DK"
        cp lang/da_DK/lang.sh build/boot/grubfm/
        ;;
    14)
        echo "pt_BR"
        cp lang/pt_BR/lang.sh build/boot/grubfm/
        ;;
    15)
        echo "ar_SA"
        cp lang/ar_SA/lang.sh build/boot/grubfm/
        ;;
    16)
        echo "ko_KR"
        cp lang/ko_KR/lang.sh build/boot/grubfm/
        ;;
    17)
        echo "hu_HU"
        cp lang/hu_HU/lang.sh build/boot/grubfm/
        ;;
    *)
        echo "en_US"
        ;;
esac
# clear 
echo ${RESET}
# this part of the build doesn't like working on WSL good?
echo "------------------------------------"
echo "${YELLOW}x86_64-efi${RESET}"
echo "------------------------------------"
echo "${CYAN}"
mkdir build/boot/grubfm/x86_64-efi
echo "${CYAN}copying "
for modules in $(cat arch/x64/builtin.lst)
do
    echo -n "${CYAN}${modules}.mod, " 
    cp grub/x86_64-efi/"${modules}".mod build/boot/grubfm/x86_64-efi/
done
# cp arch/x64/*.efi build/boot/grubfm
cp arch/x64/*.xz build/boot/grubfm
cd build
find ./boot | cpio -o -H newc | xz -9 -e > ./memdisk.xz
cd ..
rm -r build/boot/grubfm/x86_64-efi
# rm build/boot/grubfm/*.efi
rm build/boot/grubfm/*.xz
modules=$(cat arch/x64/builtin.lst)
./grub/grub-mkimage -v -m ./build/memdisk.xz -d ./grub/x86_64-efi -p "(memdisk)/boot/grubfm" -c arch/x64/config.cfg -o g2fmx64.efi -O x86_64-efi $modules
rm build/memdisk.xz
#clear
echo "${RESET}"
echo "------------------------------------"
echo "${YELLOW}i386-efi${RESET}"
echo "------------------------------------"
mkdir build/boot/grubfm/i386-efi
echo "${CYAN}copying "
for modules in $(cat arch/ia32/builtin.lst)
do
    echo "${CYAN}${modules}.mod, "
    cp grub/i386-efi/"${modules}".mod build/boot/grubfm/i386-efi/
done
# cp arch/ia32/*.efi build/boot/grubfm
cp arch/ia32/*.xz build/boot/grubfm
cd build
find ./boot | cpio -o -H newc | xz -9 -e > ./memdisk.xz
cd ..
rm -r build/boot/grubfm/i386-efi
# rm build/boot/grubfm/*.efi
rm build/boot/grubfm/*.xz
modules=$(cat arch/ia32/builtin.lst)
./grub/grub-mkimage -v -m ./build/memdisk.xz -d ./grub/i386-efi -p "(memdisk)/boot/grubfm" -c arch/ia32/config.cfg -o g2fmia32.efi -O i386-efi $modules
rm build/memdisk.xz
# clear
${RESET}
echo "------------------------------------"
echo "${YELLOW}arm64-efi${RESET}"
echo "------------------------------------"
mkdir build/boot/grubfm/arm64-efi
echo "${CYAN}copying "
for modules in $(cat arch/aa64/builtin.lst)
do
    echo "${CYAN}${modules}.mod, "
    cp grub/arm64-efi/"${modules}".mod build/boot/grubfm/arm64-efi/
done
# cp arch/aa64/*.efi build/boot/grubfm
cp arch/aa64/*.xz build/boot/grubfm
cd build
find ./boot | cpio -o -H newc | xz -9 -e > ./memdisk.xz
cd ..
rm -r build/boot/grubfm/arm64-efi
# rm build/boot/grubfm/*.efi
rm build/boot/grubfm/*.xz
modules=$(cat arch/aa64/builtin.lst)
./grub/grub-mkimage -v -m ./build/memdisk.xz -d ./grub/arm64-efi -p "(memdisk)/boot/grubfm" -c arch/aa64/config.cfg -o grubfmaa64.efi -O arm64-efi $modules
rm build/memdisk.xz
${RESET}
# clear
echo "------------------------------------"
echo "${YELLOW}i386-multiboot${RESET}"
echo "------------------------------------"
mkdir build/boot/grubfm/i386-multiboot
echo "${CYAN}copying "
for modules in $(cat arch/multiboot/builtin.lst)  
do
    echo "${CYAN}${modules}.mod, "
    cp grub/i386-multiboot/"${modules}".mod build/boot/grubfm/i386-multiboot/
done
cp arch/multiboot/*.xz build/boot/grubfm/
cp arch/multiboot/memdisk build/boot/grubfm/
cp arch/multiboot/grub.exe build/boot/grubfm/
cd build
find ./boot | cpio -o -H newc | xz -9 -e > ./memdisk.xz
cd ..
rm -r build/boot/grubfm/i386-multiboot
rm build/boot/grubfm/*.xz
rm build/boot/grubfm/memdisk
rm build/boot/grubfm/grub.exe
modules=$(cat arch/multiboot/builtin.lst)
./grub/grub-mkimage -v -m ./build/memdisk.xz -d ./grub/i386-multiboot -p "(memdisk)/boot/grubfm" -c arch/multiboot/config.cfg -o grubfm.elf -O i386-multiboot $modules
rm build/memdisk.xz
${RESET}
# clear
echo "------------------------------------------------------------------------"
echo "${YELLOW}making efi.img using files in the EFI directory${RESET}"
echo "------------------------------------------------------------------------"
dd if=/dev/zero of=build/efi.img bs=1M count=16
mkfs.vfat build/efi.img
mmd -i build/efi.img ::EFI
mmd -i build/efi.img ::EFI/BOOT
mcopy -i build/efi.img g2fmx64.efi ::EFI/BOOT/BOOTX64.EFI
mcopy -i build/efi.img g2fmia32.efi ::EFI/BOOT/BOOTIA32.EFI
echo "------------------------------------------------------------------------"
echo "${YELLOW}Loopback support${RESET}"
echo "------------------------------------------------------------------------"
cp -R boot/grub build/boot/
echo "------------------------------------------------------------------------"
echo "i386-pc preloader"
echo "------------------------------------------------------------------------"
builtin=$(cat arch/legacy/preloader.lst)
./grub/grub-mkimage -v -d ./grub/i386-pc -p "(cd)/boot/grub" -c arch/legacy/preloader.cfg -o ./build/core.img -O i386-pc $builtin
cat grub/i386-pc/cdboot.img build/core.img > build/fmldr
rm build/core.img
cp grubfm.elf build/
touch build/ventoy.dat

xorriso -as mkisofs -l -R -hide-joliet boot.catalog -b fmldr -no-emul-boot -allow-lowercase -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e efi.img -no-emul-boot -o grubfm.iso build
rm -r build
echo "${RESET}"
set bootimg_produced="$(ls *.iso *.efi *.elf)"
echo "${CYAN}"Bootable files: $bootimg_produced
echo "${CYAN}Done! To perform tests, run ./test.sh, which runs QEMU with 2 GB of RAM and 4 cores."
echo "${RESET}"
