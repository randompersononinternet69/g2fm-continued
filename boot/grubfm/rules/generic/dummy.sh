# this script allows access to the other menus in g2fm
source ${prefix}/func.sh;
if [ -f "${theme_fm}" ];
then
  export theme=${theme_fm};
fi;

menuentry "Hardware Info " --hotkey f1 {
  configfile ${prefix}/hwinfo.sh;
}

menuentry "File manager" --hotkey f2 {
  grubfm_open "${grubfm_file}";
}

menuentry "Detect operating systems" --hotkey f3 {
  configfile ${prefix}/osdetect.sh;
}

menuentry "Settings" --hotkey f4 {
  configfile ${prefix}/settings.sh;
}

menuentry "Utitlites" --hotkey f5 {
  configfile ${prefix}/util.sh;
}

menuentry "Power Options" --hotkey f6 {
  configfile ${prefix}/power.sh;
}
