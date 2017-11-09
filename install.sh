#!/bin/bash
#
# "Install" script
#

# format and create partitions
nix-env -i parted
parted -s /dev/sda \
  mklabel msdos \
  mkpart primary ext4 2048s 100%

cryptsetup luksFormat /dev/sda1
cryptsetup luksOpen /dev/sda1 crypted

mkfs.ext4 -L nixos /dev/mapper/crypted
mount /dev/disk/by-label/nixos /mnt

fallocate -l 8G /mnt/swapfile
chmod 600 /mnt/swapfile
mkswap -L swap /mnt/swapfile
swapon /mnt/swapfile

nixos-generate-config --root /mnt

curl -Sso /mnt/etc/nixos/configuration.nix https://raw.githubusercontent.com/Pamplemousse/laptop/master/etc/nixos/configuration.nix
nixos-install
