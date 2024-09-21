source ${prefix}/func.sh;
if [ -f "${theme_fm}" ];
then
  export theme=${theme_fm};
fi;

hiddenentry " " --hotkey f1 {
  echo "Sorry, this crashes GRUB2 - do NOT run - check pinned issue in repo!"
  sleep 5
  echo Returning to menu in 5 seconds
  # configfile ${prefix}/hwinfo.sh;
}

hiddenentry " " --hotkey f2 {
  grubfm_open "${grubfm_file}";
}

hiddenentry " " --hotkey f3 {
  configfile ${prefix}/osdetect.sh;
}

hiddenentry " " --hotkey f4 {
  configfile ${prefix}/settings.sh;
}

hiddenentry " " --hotkey f5 {
  configfile ${prefix}/util.sh;
}

hiddenentry " " --hotkey f6 {
  configfile ${prefix}/power.sh;
}
