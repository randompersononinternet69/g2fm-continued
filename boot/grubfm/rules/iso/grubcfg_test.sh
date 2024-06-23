source ${prefix}/func.sh;

if regexp '^hd.*' "${grubfm_device}";
then
  loopback -d loop;
  loopback loop "${grubfm_file}";
  if [ -f (loop)/boot/grub/grub.cfg ];
  then
    set grubfm_test=1;
  else
    set grubfm_test=0;
  fi;

  source ${prefix}/rules/iso/grubcfg_detect.sh;
  loopback -d loop;
fi;
