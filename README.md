# IN BETA.

* * *


# Grub2 File Manager - CONTINUED
![](https://img.shields.io/github/license/a1ive/grub2-filemanager.svg?style=flat) ![](https://img.shields.io/github/downloads/a1ive/grub2-filemanager/total.svg?style=flat) ![](https://img.shields.io/github/release/a1ive/grub2-filemanager.svg?style=flat) [![Crowdin](https://badges.crowdin.net/grub2-filemanager/localized.svg)](https://crowdin.com/project/grub2-filemanager)
## Table of Contents
- [Preview](#preview)
- [Supported types of files](#supported-types-of-files)
- [Download](download-grubfm-here.)
- [Build](#build)
- [Boot](#boot)
- [Source code](#source-code)
- [USB Installers](#usb-installers)
- [Related projects](#related-projects)
## Preview
![](https://i.imgur.com/zgz3Xeb.png)
## Supported types of files

| Type                                                         | i386-pc | i386-efi | x86_64-efi |
| :----------------------------------------------------------- | :-----: | :------: | :--------: |
| WinPE ISO |    Supported    |    Supported     |     Supported      |
| Linux ISO |    Supported    |    Supported     |     Supported      |
| Android ISO |    Supported    |    Supported     |     Supported      |
| BSD ISO |    Supported    |    Not supported     |     Not supported      |
| IMG (Disk Image) |    Supported    |    Supported     |     Supported      |
| VHD |    Supported    |    Supported     |     Supported      |
| WinPE WIM |    Supported    |    Supported     |     Supported      |
| NT5 WinPE |    Supported    |    Not supported     |     Not supported      |
| Linux/Multiboot Kernel |    Supported    |    Supported     |     Supported      |
| EFI Application |    Not supported    |    Supported     |     Supported      |

## Download GrubFM - CONTINUED [here. ](https://github.com/TCFFan123/g2fm-continued/releases)


## Build
	git clone https://github.com/TCFFan123/g2fm-continued.git
	cd g2fm-continued.git
	./update_grub.sh
	./build.sh
## Boot 
### It is recommended to use grubfm-cont-multiarch ISO.
### i386-pc 
DO NOT boot grubfm.iso with memdisk!  
#### GRUB4DOS 
	map --mem /grubfm-cont.iso (0xff)
	map --hook
	chainloader (0xff)
#### GRUB 2
	linux /loadfm  
	initrd /grubfm-cont.iso  
### x86_64-efi

#### GRUB 2 

	chainloader /grubfm-contx64.efi
#### rEFInd 
	loader /grubfm-contx64.efi
#### Systemd-boot 
	efi /grubfm-contx64.efi

 
## Source code 
GRUB2: https://github.com/a1ive/grub 

## USB Installers

* None yet. If you want to have one featured here, please open an pull request.

## Related projects

*	[GLIM](https://github.com/thias/glim) 
*	[grub-iso-boot](https://github.com/Jimmy-Z/grub-iso-boot) 
*	[grub-iso-multiboot](https://github.com/mpolitzer/grub-iso-multiboot) 
*	[GRUB2 File Explorer](http://bbs.wuyou.net/forum.php?mod=viewthread&tid=320715) 
*	[G4D AUTOMENU](http://bbs.wuyou.net/forum.php?mod=viewthread&tid=203607) 
*	[Multiboot USB](http://mbusb.aguslr.com/) 
*	[RUN](http://bbs.wuyou.net/forum.php?mod=viewthread&tid=191301) 
*	[Ventoy](https://github.com/ventoy/Ventoy)

## The original
https://github.com/a1ive/grub2-filemanager
