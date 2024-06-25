#!/usr/bin/env sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
RESET='\033[0m' # No Color
echo -n "${CYAN}---Welcome to the G2FM builder!---"
echo
echo
echo -n "${CYAN}---Installing packages...---".
sudo -E apt-get -y install gettext grub2-common genisoimage p7zip-full mtools xorriso
clear
./update_grub2.sh
clear
echo "${CYAN}Check for missing packages (everything should be found)"
echo -n "${CYAN}Checking for gettext... "
if [ "$(which msgfmt)" ]
then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease install gettext."
    exit
fi
echo -n "${CYAN}Checking for xorriso... "
if [ "$(which xorriso)" ]
then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease install xorriso."
    exit
fi
echo -n "${CYAN}Checking for grub... "
if [ "$(which grub-mkimage)" ]
then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease install grub."
    exit
fi
echo -n "${CYAN}Checking for mtools... "
if [ "$(which mtools)" ]
then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease install mtools."
    exit
fi

if [ -d "build" ]
then
    rm -r build
fi
mkdir build
clear
echo -n ${RESET}
clear
echo "${CYAN}---Making a copy of /boot to /build---"
cat /proc/sys/kernel/random/uuid >boot/grubfm/ver.txt
cp -r boot build/

cp grub/locale/*.mo build/boot/grubfm/locale/
cd lang
for po in */fm.po; do
  msgfmt ${po} -o ../build/boot/grubfm/locale/fm/${po%/*}.mo
done
cd ..
clear

echo "${CYAN}Select a language${RESET}"
echo "${GREEN}1. ${YELLOW}Simplified Chinese${RESET}"
echo "${GREEN}2. ${YELLOW}Traditional Chinese${RESET}"
echo "${GREEN}3. ${YELLOW}English (United States)${RESET}"
echo "${GREEN}4. ${YELLOW}Turkish${RESET}"
echo "${GREEN}5. ${YELLOW}German${RESET}"
echo "${GREEN}6. ${YELLOW}Vietnamese${RESET}"
echo "${GREEN}7. ${YELLOW}Russian${RESET}"
echo "${GREEN}8. ${YELLOW}Hebrew${RESET}"
echo "${GREEN}9. ${YELLOW}Spanish${RESET}"
echo "${GREEN}10. ${YELLOW}Polish${RESET}"
echo "${GREEN}11. ${YELLOW}Ukrainian${RESET}"
echo "${GREEN}12. ${YELLOW}French${RESET}"
echo "${GREEN}13. ${YELLOW}Danish${RESET}"
echo "${GREEN}14. ${YELLOW}Portuguese (Brazil)${RESET}"
echo "${GREEN}15. ${YELLOW}Arabic${RESET}"
echo "${GREEN}16. ${YELLOW}Korean${RESET}"
echo "${GREEN}17. ${YELLOW}Hungarian${RESET}"

read -p "$(echo "${CYAN}Select one: ")" choice

case "$choice" in
    2)
        echo "${GREEN}zh_TW"
        cp lang/zh_TW/lang.sh build/boot/grubfm/
        ;;
    3)
        echo "${GREEN}en_US"
        ;;
    4)
        echo "${GREEN}tr_TR"
        cp lang/tr_TR/lang.sh build/boot/grubfm/
        ;;
    5)
        echo "${GREEN}de_DE"
        cp lang/de_DE/lang.sh build/boot/grubfm/
        ;;
    6)
        echo "${GREEN}vi_VN"
        cp lang/vi_VN/lang.sh build/boot/grubfm/
        ;;
    7)
        echo "${GREEN}ru_RU"
        cp lang/ru_RU/lang.sh build/boot/grubfm/
        ;;
    8)
        echo "${GREEN}he_IL"
        cp lang/he_IL/lang.sh build/boot/grubfm/
        ;;
    9)
        echo "${GREEN}es_ES"
        cp lang/es_ES/lang.sh build/boot/grubfm/
        ;;
    10)
        echo "${GREEN}pl_PL"
        cp lang/pl_PL/lang.sh build/boot/grubfm/
        ;;
    11)
        echo "${GREEN}uk_UA"
        cp lang/uk_UA/lang.sh build/boot/grubfm/
        ;;
    12)
        echo "${GREEN}fr_FR"
        cp lang/fr_FR/lang.sh build/boot/grubfm/
        ;;
    13)
        echo "${GREEN}da_DK"
        cp lang/da_DK/lang.sh build/boot/grubfm/
        ;;
    14)
        echo "${GREEN}pt_BR"
        cp lang/pt_BR/lang.sh build/boot/grubfm/
        ;;
    15)
        echo "${GREEN}ar_SA"
        cp lang/ar_SA/lang.sh build/boot/grubfm/
        ;;
    16)
        echo "${GREEN}ko_KR"
        cp lang/ko_KR/lang.sh build/boot/grubfm/
        ;;
    17)
        echo "${GREEN}hu_HU"
        cp lang/hu_HU/lang.sh build/boot/grubfm/
        ;;
    *)
        echo "${GREEN}en_US"
        ;;
esac
clear && echo ${RESET}
echo "${YELLOW}x86_64-efi${RESET}"
echo ${CYAN}
mkdir build/boot/grubfm/x86_64-efi
for modules in $(cat arch/x64/optional.lst)
do
    echo "${CYAN}copying ${modules}.mod"
    cp grub/x86_64-efi/${modules}.mod build/boot/grubfm/x86_64-efi/
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
./grub/grub-mkimage -m ./build/memdisk.xz -d ./grub/x86_64-efi -p "(memdisk)/boot/grubfm" -c arch/x64/config.cfg -o g2fmx64.efi -O x86_64-efi $modules
rm build/memdisk.xz
clear
echo "${YELLOW}i386-efi${RESET}"
mkdir build/boot/grubfm/i386-efi
for modules in $(cat arch/ia32/optional.lst)
do
    echo "${CYAN}copying ${modules}.mod"
    cp grub/i386-efi/${modules}.mod build/boot/grubfm/i386-efi/
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
./grub/grub-mkimage -m ./build/memdisk.xz -d ./grub/i386-efi -p "(memdisk)/boot/grubfm" -c arch/ia32/config.cfg -o g2fmia32.efi -O i386-efi $modules
rm build/memdisk.xz
clear
echo "${YELLOW}arm64-efi${RESET}"
mkdir build/boot/grubfm/arm64-efi
for modules in $(cat arch/aa64/optional.lst)
do
    echo "${CYAN}copying ${modules}.mod"
    cp grub/arm64-efi/${modules}.mod build/boot/grubfm/arm64-efi/
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
./grub/grub-mkimage -m ./build/memdisk.xz -d ./grub/arm64-efi -p "(memdisk)/boot/grubfm" -c arch/aa64/config.cfg -o grubfmaa64.efi -O arm64-efi $modules
rm build/memdisk.xz

echo "${YELLOW}i386-multiboot${RESET}"
mkdir build/boot/grubfm/i386-multiboot
for modules in $(cat arch/multiboot/optional.lst)
do
    echo "${CYAN}copying ${modules}.mod"
    cp grub/i386-multiboot/${modules}.mod build/boot/grubfm/i386-multiboot/
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
./grub/grub-mkimage -m ./build/memdisk.xz -d ./grub/i386-multiboot -p "(memdisk)/boot/grubfm" -c arch/multiboot/config.cfg -o grubfm.elf -O i386-multiboot $modules
rm build/memdisk.xz

echo "${YELLOW}i386-pc${RESET}"
builtin=$(cat arch/legacy/builtin.lst)
mkdir build/boot/grubfm/i386-pc
modlist="$(cat arch/legacy/insmod.lst) $(cat arch/legacy/optional.lst)"
for modules in $modlist
do
    echo "${CYAN}copying ${modules}.mod"
    cp grub/i386-pc/${modules}.mod build/boot/grubfm/i386-pc/
done
cp arch/legacy/insmod.lst build/boot/grubfm/
cp arch/multiboot/*.xz build/boot/grubfm/
cp arch/multiboot/memdisk build/boot/grubfm/
cp arch/multiboot/grub.exe build/boot/grubfm/
cd build
find ./boot | cpio -o -H newc | xz -9 -e > ./fm.loop
cd ..
rm -r build/boot
./grub/grub-mkimage -d ./grub/i386-pc -p "(memdisk)/boot/grubfm" -c arch/legacy/config.cfg -o ./build/core.img -O i386-pc $builtin
cat grub/i386-pc/cdboot.img build/core.img > build/fmldr
rm build/core.img
touch build/ventoy.dat
echo "{$YELLOW}Loopback support{$RESET}"
mkdir boot/grub
cp loopback/loopback.cfg boot/grub/
cp -R boot/grub build/boot/
xorriso -as mkisofs -l -R -hide-joliet boot.catalog -b fmldr -no-emul-boot -allow-lowercase -boot-load-size 4 -boot-info-table -o grubfm_pc.iso build
rm build/fmldr
rm build/fm.loop

echo "${YELLOW}i386-pc preloader${RESET}"
builtin=$(cat arch/legacy/preloader.lst)
./grub/grub-mkimage -d ./grub/i386-pc -p "(cd)/boot/grub" -c arch/legacy/preloader.cfg -o ./build/core.img -O i386-pc $builtin
cat grub/i386-pc/cdboot.img build/core.img > build/fmldr
rm build/core.img
cp grubfm.elf build/
touch build/ventoy.dat
echo "{$YELLOW}Loopback support{$RESET}"
mkdir boot/grub
cp loopback/loopback.cfg boot/grub/
cp -R boot/grub build/boot/
xorriso -as mkisofs -l -R -hide-joliet boot.catalog -b fmldr -no-emul-boot -allow-lowercase -boot-load-size 4 -boot-info-table -o grubfm.iso build

echo "${YELLOW}making efi.img using files in the EFI directory${RESET}"
dd if=/dev/zero of=build/efi.img bs=1M count=16
mkfs.vfat build/efi.img
mmd -i build/efi.img ::EFI
mmd -i build/efi.img ::EFI/BOOT
mcopy -i build/efi.img g2fmx64.efi ::EFI/BOOT/BOOTX64.EFI
mcopy -i build/efi.img g2fmia32.efi ::EFI/BOOT/BOOTIA32.EFI
echo "{$YELLOW}Loopback support{$RESET}"
mkdir boot/grub
cp loopback/loopback.cfg boot/grub/
cp -R boot/grub build/boot/
xorriso -as mkisofs -l -R -hide-joliet boot.catalog -b fmldr -no-emul-boot -allow-lowercase -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e efi.img -no-emul-boot -o g2fm_multiarch.iso build

rm -r build
echo ${CYAN}Done!
