# IN BETA.

* * *


# Grub2 File Manager - CONTINUED
![image](https://github.com/TCFFan123/g2fm-continued/assets/107446530/c6d4f361-5f80-4e15-8241-7c76afa5b95c)
Star if you like it!

**NEW!**

Wiki is here! https://github.com/TCFFan123/g2fm-continued/wiki

We're looking for more contributors! (I'm the only one so far who has made changes in this repo. GitHub says there's 10 contributors but that's some weird issue with detaching a fork)

If you find something wrong, report it in issues.

Think that something could change in g2fm? Create a pull request.

Here's a guide on how to make a pull request, if you're new to GitHub: https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request?platform=windows

## Table of Contents
- [Preview](#preview)
- [Supported types of files](#supported-types-of-files)
- [Download](download-g2fm-here.)
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

## Download g2fm - CONTINUED [here. ](https://github.com/TCFFan123/g2fm-continued/releases)


## Build
	git clone https://github.com/TCFFan123/g2fm-continued.git
	cd g2fm-continued
	./update_grub.sh
	./build.sh
## Boot 
### It is recommended to use g2fm-multiarch ISO.
### i386-pc 
DO NOT boot g2fm.iso with memdisk!  
#### GRUB4DOS 
	map --mem /g2fm.iso (0xff)
	map --hook
	chainloader (0xff)
#### GRUB 2
	linux /loadfm  
	initrd /g2fm.iso  
### x86_64-efi

#### GRUB 2 

	chainloader /g2fmx64.efi
#### rEFInd 
	loader /g2fmx64.efi
#### Systemd-boot 
	efi /g2fmx64.efi

 
## Source code 
GRUB2: https://github.com/tcffan123/grub 

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
