echo Booting grubfm_multiarch.iso with 2GB RAM, and 4 cores.
kvm -m 2048 -smp 4 -cpu host -cdrom grubfm.iso
