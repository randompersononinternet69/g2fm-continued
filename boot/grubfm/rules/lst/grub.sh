# some commands will not work with this mode, since it translates menu.lst commands to grub.cfg
source ${prefix}/func.sh;

set root=${grubfm_device};
if [ -f "${theme_std}" ];
then
  export theme=${theme_std};
fi;
legacy_configfile "${grubfm_file}";
