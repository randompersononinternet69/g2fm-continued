# GRUB2 FILE MANAGER

![Static Badge](https://img.shields.io/badge/IN_BETA!-red?style=for-the-badge)

It's GRUB2... but as a file manager with lots of features.
**project on pause**

## Features

- A variety of operating systems are supported (Windows XP-11, lot's of Linux distros, etc.)
- Supports multiple architectures (ARM64, x86, x86_64)
- Windows Installer unattend support
- Monitor hardware feature (currently broken)
- Very customizable
- Can still run, even after the disk is changed, since it runs in RAM!
- Can be run from any type of bootable writable drive that has at least 64 MB of storage

Based on: [a1ive's grub2 file manager](https://github.com/a1ive/grub2-filemanager)

Star if you like it!

![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/TCFFan123/g2fm-continued/total?style=for-the-badge&labelColor=black&color=blue)
![GitHub Release](https://img.shields.io/github/v/release/TCFFan123/g2fm-continued?display_name=release&style=for-the-badge&labelColor=black)
![GitHub Repo stars](https://img.shields.io/github/stars/TCFFan123/g2fm-continued?style=for-the-badge&logo=github&labelColor=black)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/TCFFan123/g2fm-continued/build.yml?style=for-the-badge&labelColor=black&color=blue)
> [!NOTE]
> We're looking for more contributors!
>
> I'm the only one so far who has made changes in this fork of grubfm. GitHub says there's 10 contributors but that's because this is a fork of grubfm, which has kept the existing contributor history (this is done by GitHub). Ever since the fork was made, it was just me making commits after to this fork.
>
> If you find something wrong or want to request a new feature, report it in issues.
>
> Think that something could be changed/added in g2fm, and you know GRUB2? Create a pull request with the code for the feature.

## Table of Contents

- [Preview](#preview)
- [Supported types of files](#supported-types-of-files)
- [Build](#build)
- [Boot](#boot-methods)
- [Source code](#source-code)
- [USB Installers](#usb-installers)
- [Related projects](#related-projects)

## Preview

![image](https://github.com/user-attachments/assets/1502bd3a-6bde-41c5-9e13-f09cf3854c80)


## Supported types of files

| Type                   |    i386-pc    |   i386-efi    |  x86_64-efi   |
| :--------------------- | :-----------: | :-----------: | :-----------: |
| WinPE/Windows Install ISO              |   Supported   |   Supported   |   Supported   |
| Linux ISO              |   Supported   |   Supported   |   Supported   |
| Android x86 ISO            |   Supported   |   Supported   |   Supported   |
| BSD ISO                |   Supported   | Not supported | Not supported |
| IMG (Disk Image)       |   Supported   |   Supported   |   Supported   |
| VHD                    |   Supported   |   Supported   |   Supported   |
| WinPE WIM              |   Supported   |   Supported   |   Supported   |
| NT5 WinPE              |   Supported   | Not supported | Not supported |
| Linux/Multiboot Kernel |   Supported   |   Supported   |   Supported   |
| EFI Application        | Not supported |   Supported   |   Supported   |

## Build

```bash
 git clone <https://github.com/TCFFan123/g2fm-continued.git>
 cd g2fm-continued
 ./update_grub.sh
 ./build.sh
```

## Boot methods

### i386-pc

Do **NOT** boot g2fm.iso with memdisk!

#### GRUB4DOS / GRUB Legacy

```bash
 map --mem /g2fm.iso (0xff)
 map --hook
 chainloader (0xff)
```

#### GRUB2

```bash
 linux /loadfm
 initrd /g2fm.iso
```

### x86_64-efi

#### GRUB2

```bash
 chainloader /g2fmx64.efi
```

#### rEFInd

```bash
 loader /g2fmx64.efi
```

#### Systemd-boot

```bash
 efi /g2fmx64.efi
```

## Source code

GRUB2: <https://github.com/tcffan123/grub>

## USB Installers

- Windows command prompt USB installer at <https://github.com/TCFFan123/g2fm-continued/blob/df29f9fe139af7bfa7c327bf2d28865b97d5041e/samples/usb_install.cmd>

> [!NOTE]
>If you want to have one featured here, please open an issue.

## Related projects

- [GLIM](https://github.com/thias/glim)
- [grub-iso-boot](https://github.com/Jimmy-Z/grub-iso-boot)
- [grub-iso-multiboot](https://github.com/mpolitzer/grub-iso-multiboot)
- [GRUB2 File Explorer](http://bbs.wuyou.net/forum.php?mod=viewthread&tid=320715)
- [G4D AUTOMENU](http://bbs.wuyou.net/forum.php?mod=viewthread&tid=203607)
- [Multiboot USB](http://mbusb.aguslr.com/)
- [RUN](http://bbs.wuyou.net/forum.php?mod=viewthread&tid=191301)
- [Ventoy](https://github.com/ventoy/Ventoy)
