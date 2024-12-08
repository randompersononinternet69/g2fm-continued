#!/usr/bin/bash
echo Booting grubfm_multiarch.iso with 2GB RAM.
kvm -m 2048 -cdrom grubfm.iso $@
