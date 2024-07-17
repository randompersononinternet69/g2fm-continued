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
if [ "$(which msgfmt)" ]; then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease install gettext."
    exit
fi
echo -n "${CYAN}Checking for xorriso... "
if [ "$(which xorriso)" ]; then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease install xorriso."
    exit
fi
echo -n "${CYAN}Checking for grub... "
if [ "$(which grub-mkimage)" ]; then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease install grub."
    exit
fi
echo -n "${CYAN}Checking for mtools... "
if [ "$(which mtools)" ]; then
    echo "${CYAN}ok"
else
    echo "${CYAN}Not found\nPlease install mtools."
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
cat /proc/sys/kernel/random/uuid >boot/grubfm/ver.txt
cp -r boot build/

cp grub/locale/*.mo build/boot/grubfm/locale/
cd lang
for po in */fm.po; do
  msgfmt ${po} -o ../build/boot/grubfm/locale/fm/${po%/*}.mo
done
cd ..
clear

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# Array of menu options
options=(
    "Simplified Chinese"
    "Traditional Chinese"
    "English (United States)"
    "Turkish"
    "German"
    "Vietnamese"
    "Russian"
    "Hebrew"
    "Spanish"
    "Polish"
    "Ukrainian"
    "French"
    "Danish"
    "Portuguese (Brazil)"
    "Arabic"
    "Korean"
    "Hungarian"
)

# Array of corresponding language codes and paths
codes=(
    "zh_CN"
    "zh_TW"
    "en_US"
    "tr_TR"
    "de_DE"
    "vi_VN"
    "ru_RU"
    "he_IL"
    "es_ES"
    "pl_PL"
    "uk_UA"
    "fr_FR"
    "da_DK"
    "pt_BR"
    "ar_SA"
    "ko_KR"
    "hu_HU"
)

if [ "$1" = "--old-style" ]; then
    # Old style menu
    echo "${CYAN}Select a language${RESET}"
    for i in "${!options[@]}"; do
        echo "${GREEN}$((i + 1)). ${YELLOW}${options[i]}${RESET}"
    done

    read -p "$(echo "${CYAN}Select one: ")" choice

    case "$choice" in
        1) echo "${GREEN}${codes[0]}"; cp lang/${codes[0]}/lang.sh build/boot/grubfm/ ;;
        2) echo "${GREEN}${codes[1]}"; cp lang/${codes[1]}/lang.sh build/boot/grubfm/ ;;
        3) echo "${GREEN}${codes[2]}"; ;;
        4) echo "${GREEN}${codes[3]}"; cp lang/${codes[3]}/lang.sh build/boot/grubfm/ ;;
        5) echo "${GREEN}${codes[4]}"; cp lang/${codes[4]}/lang.sh build/boot/grubfm/ ;;
        6) echo "${GREEN}${codes[5]}"; cp lang/${codes[5]}/lang.sh build/boot/grubfm/ ;;
        7) echo "${GREEN}${codes[6]}"; cp lang/${codes[6]}/lang.sh build/boot/grubfm/ ;;
        8) echo "${GREEN}${codes[7]}"; cp lang/${codes[7]}/lang.sh build/boot/grubfm/ ;;
        9) echo "${GREEN}${codes[8]}"; cp lang/${codes[8]}/lang.sh build/boot/grubfm/ ;;
        10) echo "${GREEN}${codes[9]}"; cp lang/${codes[9]}/lang.sh build/boot/grubfm/ ;;
        11) echo "${GREEN}${codes[10]}"; cp lang/${codes[10]}/lang.sh build/boot/grubfm/ ;;
        12) echo "${GREEN}${codes[11]}"; cp lang/${codes[11]}/lang.sh build/boot/grubfm/ ;;
        13) echo "${GREEN}${codes[12]}"; cp lang/${codes[12]}/lang.sh build/boot/grubfm/ ;;
        14) echo "${GREEN}${codes[13]}"; cp lang/${codes[13]}/lang.sh build/boot/grubfm/ ;;
        15) echo "${GREEN}${codes[14]}"; cp lang/${codes[14]}/lang.sh build/boot/grubfm/ ;;
        16) echo "${GREEN}${codes[15]}"; cp lang/${codes[15]}/lang.sh build/boot/grubfm/ ;;
        17) echo "${GREEN}${codes[16]}"; cp lang/${codes[16]}/lang.sh build/boot/grubfm/ ;;
        *) echo "${GREEN}en_US" ;;
    esac
else
    # New style menu
    # Function to print the menu
    print_menu() {
        echo -e "${CYAN}Select a language${RESET}"
        for i in "${!options[@]}"; do
            if [ $i -eq $1 ]; then
                echo -e "${GREEN}> ${YELLOW}${options[i]}${RESET}"
            else
                echo -e "  ${options[i]}"
            fi
        done
    }

    # Initial position
    position=0

    # Print the initial menu
    clear
    print_menu $position

    # Read user input
    while true; do
        read -s -n 1 key
        case $key in
            $'\x1b')
                read -s -n 1 key
                if [ "$key" == "[" ]; then
                    read -s -n 1 key
                    case $key in
                        A) # Up arrow
                            ((position--))
                            if [ $position -lt 0 ]; then
                                position=$((${#options[@]} - 1))
                            fi
                            ;;
                        B) # Down arrow
                            ((position++))
                            if [ $position -ge ${#options[@]} ]; then
                                position=0
                            fi
                            ;;
                    esac
                fi
                ;;
            "") # Enter key
                choice=$position
                break
                ;;
        esac
        clear
        print_menu $position
    done

    # Handle the selected option
    case "$choice" in
        1) echo "${GREEN}${codes[1]}"; cp lang/${codes[1]}/lang.sh build/boot/grubfm/ ;;
        2) echo "${GREEN}${codes[2]}"; ;;
        3) echo "${GREEN}${codes[3]}"; cp lang/${codes[3]}/lang.sh build/boot/grubfm/ ;;
        4) echo "${GREEN}${codes[4]}"; cp lang/${codes[4]}/lang.sh build/boot/grubfm/ ;;
        5) echo "${GREEN}${codes[5]}"; cp lang/${codes[5]}/lang.sh build/boot/grubfm/ ;;
        6) echo "${GREEN}${codes[6]}"; cp lang/${codes[6]}/lang.sh build/boot/grubfm/ ;;
        7) echo "${GREEN}${codes[7]}"; cp lang/${codes[7]}/lang.sh build/boot/grubfm/ ;;
        8) echo "${GREEN}${codes[8]}"; cp lang/${codes[8]}/lang.sh build/boot/grubfm/ ;;
        9) echo "${GREEN}${codes[9]}"; cp lang/${codes[9]}/lang.sh build/boot/grubfm/ ;;
        10) echo "${GREEN}${codes[10]}"; cp lang/${codes[10]}/lang.sh build/boot/grubfm/ ;;
        11) echo "${GREEN}${codes[11]}"; cp lang/${codes[11]}/lang.sh build/boot/grubfm/ ;;
        12) echo "${GREEN}${codes[12]}"; cp lang/${codes[12]}/lang.sh build/boot/grubfm/ ;;
        13) echo "${GREEN}${codes[13]}"; cp lang/${codes[13]}/lang.sh build/boot/grubfm/ ;;
        14) echo "${GREEN}${codes[14]}"; cp lang/${codes[14]}/lang.sh build/boot/grubfm/ ;;
        15) echo "${GREEN}${codes[15]}"; cp lang/${codes[15]}/lang.sh build/boot/grubfm/ ;;
        16) echo "${GREEN}${codes[16]}"; cp lang/${codes[16]}/lang.sh build/boot/grubfm/ ;;
        0) echo "${GREEN}${codes[0]}"; cp lang/${codes[0]}/lang.sh build/boot/grubfm/ ;;
    esac
fi
clear && echo ${RESET}
echo "------------------------------------"
echo "${YELLOW}x86_64-efi${RESET}"
echo "------------------------------------"
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
echo "------------------------------------"
echo "${YELLOW}i386-efi${RESET}"
echo "------------------------------------"
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
echo "------------------------------------"
echo "${YELLOW}arm64-efi${RESET}"
echo "------------------------------------"
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

echo "------------------------------------"
echo "${YELLOW}i386-multiboot${RESET}"
echo "------------------------------------"
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

echo "------------------------------------------------------------------------"
echo "${YELLOW}making efi.img using files in the EFI directory${RESET}"
echo "------------------------------------------------------------------------"
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

echo "i386-pc preloader"
builtin=$(cat arch/legacy/preloader.lst)
./grub/grub-mkimage -d ./grub/i386-pc -p "(cd)/boot/grub" -c arch/legacy/preloader.cfg -o ./build/core.img -O i386-pc $builtin
cat grub/i386-pc/cdboot.img build/core.img > build/fmldr
rm build/core.img
cp grubfm.elf build/
touch build/ventoy.dat

# i didn't even touch any "fmldr" related files and xorriso just fails???
xorriso -as mkisofs -l -R -hide-joliet boot.catalog -b fmldr -no-emul-boot -allow-lowercase -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e efi.img -no-emul-boot -o grubfm.iso build

rm -r build
echo ${CYAN}Done!
