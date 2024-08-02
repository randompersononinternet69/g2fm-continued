local sh_list = {
  "distro/alt.sh",
  "distro/andmenu.sh",
  "distro/android.sh",
  "distro/antix.sh",
  "distro/archlinux.sh",
  "distro/austrumi.sh",
  "distro/blackarch.sh",
  "distro/calculate.sh",
  "distro/cdlinux.sh",
  "distro/chakra.sh",
  "distro/debian.sh",
  "distro/debinstmenu.sh",
  "distro/debmenu.sh",
  "distro/dsl-old.sh",
  "distro/fedora.sh",
  "distro/freebsd.sh",
  "distro/gentoo.sh",
  "distro/hyper.sh",
  "distro/ipfire.sh",
  "distro/kaos.sh",
  "distro/knoppix.sh",
  "distro/krd.sh",
  "distro/liveslack.sh",
  "distro/netbsd.sh",
  "distro/openbsd.sh",
  "distro/parabola.sh",
  "distro/pclinuxos.sh",
  "distro/pentoo.sh",
  "distro/plop.sh",
  "distro/pmagic.sh",
  "distro/porteus.sh",
  "distro/proxmox.sh",
  "distro/sabayon.sh",
  "distro/siduction.sh",
  "distro/slax.sh",
  "distro/smartos.sh",
  "distro/suse64.sh",
  "distro/sysrcd.sh",
  "distro/sysresccd.sh",
  "distro/tinycore.sh",
  "distro/ubuntu.sh",
  "distro/veket.sh",
  "distro/wifislax.sh",
  "distro/win.sh",
  "distro/winxp.sh",
  "func.sh",
  "global.sh",
  "hwinfo.sh",
  "init.sh",
  "lang.sh",
  "netboot.sh",
  "osdetect.sh",
  "power.sh",
  "pxeinit.sh",
  "search.sh",
  "settings.sh",
  "util.sh"
}

local function search_sh (sh_table)
  local j = 0
  for i, wim in ipairs (sh_list) do
    if (grub.file_exist (sh)) then
      print ("found .sh file " .. sh")
      j = j + 1
      sh_table[j] = sh
    end
  end
  return j
end