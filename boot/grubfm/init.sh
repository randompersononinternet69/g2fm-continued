# Grub2-FileManager
# Copyright (C) 2016,2017,2018,2019,2020  A1ive.
#
# Grub2-FileManager is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# Grub2-FileManager is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Grub2-FileManager.  If not, see <http://www.gnu.org/licenses/>.

echo Starting G2FM beta...
set color_normal=yellow/black
echo " "
# The following code is from agFM for Easy2Boot
echo " "
echo "----------------------"
echo "PLATFORM INFORMATION"
echo "----------------------"
echo "CPU: ${grub_cpu}"
echo "Platform: ${grub_platform}"
echo "Boot drive: $bootdev"
echo "RAM: ${RAM} MB"
echo " "

set CPU64=false; set CPU32=false; set MBR=false; set EFI=false; set EFI64=false; set EFI32=false; set MBR32=false; set MBR64=false
echo "Setting CPU64 to false"
echo "Setting CPU32 to false"
echo "Setting MBR to false"
echo "Setting EFI to false"
echo "Setting EFI64 to false"
echo "Setting EFI32 to false"
echo "Setting MBR32 to false"
echo "Setting MBR64 to false"
set CPU32=true
if cpuid -l; then set CPU64=true; fi
if [ "${grub_cpu}" == "x86_64" ]; then set CPU64=true; fi
if $CPU64 == true ; then set CPU32=false ; fi
echo "Set CPU32 to ${CPU32}"
if [ "${grub_platform}" == "efi" ]; then set EFI=true; else set MBR=true; fi
echo "Set MBR to ${MBR}"
echo "Set EFI to ${EFI}"
if [ "${grub_cpu}" == "x86_64" -a $EFI = true ]; then set EFI64=true; fi
if [ "${grub_cpu}" == "i386" -a $EFI = true ]; then set EFI32=true; fi
if [ $CPU64 = true -a $MBR = true ]; then set MBR64=true; fi
if [ $CPU32 = true -a $MBR = true ]; then set MBR32=true; fi
export MBR EFI MBR32 MBR64 EFI32 EFI64 CPU32 CPU64
export grub_secureboot=$"Not available"
stat -r -q -s RAM
export RAM
# a random string of text is shown after the dash, for example: "v1.0.20-235ba555-c959-48b4-a26c-7520a0040e2a"
echo "Version: v1.0.0a";
echo -n Build ID:
cat ${prefix}/boot/grubfm/ver
export pager=0;
cat --set=modlist ${prefix}/insmod.lst;
for module in ${modlist};
do
  insmod ${module};
done;
export enable_progress_indicator=0;
if [ "${grub_platform}" = "efi" ];
then
  search -s -f -q /efi/microsoft/boot/bootmgfw.efi;
  if [ "${grub_cpu}" = "i386" ];
  then
    export EFI_ARCH="ia32";
  elif [ "${grub_cpu}" = "arm64" ];
  then
    export EFI_ARCH="aa64";
  else
    export EFI_ARCH="x64";
  fi;
  search -s -f -q /efi/boot/boot${EFI_ARCH}.efi;
  getenv -t uint8 SecureBoot grub_secureboot;
  if [ "${grub_secureboot}" = "1" ];
  then
    export grub_secureboot=$"Enabled";
    sbpolicy -i;
    echo "Secure boot is $grub_secureboot";
  fi;
  if [ "${grub_secureboot}" = "0" ];
  then
    export grub_secureboot=$"Disabled";
    echo "Secure boot is $grub_secureboot";
  fi;
else
  search -s -f -q /fmldr;
fi;

if cpuid -l;
then
  export CPU=64;
else
  export CPU=32;
fi
stat -r -q -s RAM;
export RAM;

loadfont ${prefix}/fonts/unicode.xz;

export locale_dir=${prefix}/locale;
export secondary_locale_dir=${prefix}/locale/fm;

source ${prefix}/lang.sh;

export grub_disable_esc="1";
export color_normal=white/black;
export color_highlight=black/white;

if [ "${grub_mb_firmware}" = "unknown" ];
then
  terminal_input at_keyboard;
fi;

search --set=aioboot -f -q -n /AIO/grub/grub.cfg;
export aioboot;
search --set=ventoy -f -q -n /ventoy/ventoy.cpio;
export ventoy;

export theme_std=${prefix}/themes/slack/theme.txt;
export theme_fm=${prefix}/themes/slack/fm.txt;
export theme_info=${prefix}/themes/slack/info.txt;
export theme_hw_grub=${prefix}/themes/slack/hwinfo/grub.txt;
export theme_hw_cpu=${prefix}/themes/slack/hwinfo/cpu.txt;
export theme_hw_ram=${prefix}/themes/slack/hwinfo/ram.txt;
export theme_hw_board=${prefix}/themes/slack/hwinfo/board.txt;

export theme=${theme_std};

search --set=user -f -q /boot/grubfm/config
export user

set default_choice=no
if [ -n "${user}" ];
  then
    echo "Found a custom config at /boot/grubfm/config. Do you want to load the custom config? (yes/no)"
    read choice
  fi

if [ "$choice" = "yes" ];
then
  if [ -n "${user}" ];
  then
    grubfm_set -u "${user}"
    source (${user})/boot/grubfm/config
    echo "Loaded custom config from /boot/grubfm/config";
  fi
else
  clear
  echo init VGA buffer
  export gfxmode=auto;
  export gfxpayload=keep;
  terminal_output gfxterm
  grubfm
fi

