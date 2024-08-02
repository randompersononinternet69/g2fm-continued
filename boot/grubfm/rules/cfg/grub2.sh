source ${prefix}/func.sh;

set root=${grubfm_device};
if [ -f "${theme_std}" ];
then
  export theme=(memdisk)/boot/grubfm/themes/slack/theme.txt;
fi;
configfile "${grubfm_file}";
