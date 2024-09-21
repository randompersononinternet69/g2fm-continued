#!/usr/bin/bash
echo Booting grubfm_multiarch.iso with 2GB RAM, and 4 cores.
kvm -m 2048 -smp 4 -cdrom grubfm.iso $1 $2 $3 $4 $5
