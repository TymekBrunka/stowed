#/usr/bin/bash
#based around https://computingforgeeks.com/install-kvm-qemu-virt-manager-arch-manjar/
sudo pacman -S\
    qemu\
    virt-manager\
    virt-viewer\
    dnsmasq\
    vde2\
    bridge-utils\
    openbsd-netcat\
    libguestfs\
    vde2\
    openbsd-netcat\
    nftables\
    swtpm

sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service

sudo cp /etc/libvirt/libvirt.conf /etc/libvirt/libvirt.conf.backup
sudo cp ~/scripts/onetime/libvirt.conf /etc/libvirt/libvirt.conf

sudo usermod -a -G libvirt $(whoami)
newgrp libvirt

sudo systemctl restart libvirtd.service

### Intel Processor ###
sudo modprobe -r kvm_intel
sudo modprobe kvm_intel nested=1

# ### AMD Processor ###
# sudo modprobe -r kvm_amd
# sudo modprobe kvm_amd nested=1
