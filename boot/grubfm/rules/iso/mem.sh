source ${prefix}/func.sh;

#detect WinBuilder ISO and modify ini files
	loopback -d loop;
	loopback loop "${grubfm_file}";
	set installiso="${grubfm_path}";
	tr --set=installiso "/" "\\";
	loopback -d spaces
	loopback -m spaces "(${user})/boot/grubfm/spaces.gz"
	set "iso1=[IsoInfo]\x0d\x0aIsoName=${installiso}\x0d\x0a"
	unset iso1;
	unset installiso;
	loopback -d spaces;
	fi

if [ "$grub_platform" = "efi" ];
then
  set enable_progress_indicator=1;
  map -f -m "${grubfm_file}";
elif [ "$grub_platform" = "pc" ];
then
  to_g4d_path "${grubfm_file}";
  if [ -n "${g4d_path}" ];
  then
    set enable_progress_indicator=1;
      set g4d_cmd="map --mem (rd)+1 (fd0) ;; map --hook ;; configfile (fd0)/menu.lst";
      to_g4d_menu "set file=${g4d_path}\x0amap --mem %file% (0xff)\x0amap --hook\x0achainloader (0xff)\x0aboot";
      linux (${user})/boot/grubfm/grub.exe --config-file=${g4d_cmd};
      initrd (rd);
	  boot;
  else
    set enable_progress_indicator=1;
    linux16 ${prefix}/memdisk iso raw;
    initrd16 "${grubfm_file}";
  fi;
  boot;
fi;
