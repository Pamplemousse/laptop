#!/run/current-system/sw/bin/bash
#
# "Install" script
#

fdisk -l
read -p -r "Which disk shall we install everything on? (eg: /dev/sda) " DISK
read -p -r "How much RAM is there on this laptop in GiB? " RAM

# format and create partitions
sgdisk -og "$DISK"
sgdisk -n 1:2048:4095 -c 1:"BIOS boot partition" -t 1:ef02 "$DISK"
sgdisk -n 2:0:+550MiB -c 2:"EFI system partition" -t 2:ef00 "$DISK"
sgdisk -n 3:0:+3MiB -c 3:"cryptsetup luks key" -t 3:8300 "$DISK"
sgdisk -n 4:0:+"${RAM}"GiB -c 4:"swap space (hibernation)" -t 4:8300 "$DISK"
sgdisk -n 5:0:"$(sgdisk -E "$DISK")" -c 5:"root filesystem" -t 5:8300 "$DISK"

cryptsetup luksFormat "${DISK}3"
cryptsetup luksOpen "${DISK}3" cryptkey

dd if=/dev/random of=/dev/mapper/cryptkey bs=1024 count=14000

cryptsetup luksFormat --key-file=/dev/mapper/cryptkey "${DISK}4"

cryptsetup luksFormat "${DISK}5"
cryptsetup luksAddKey "${DISK}5" /dev/mapper/cryptkey

cryptsetup luksOpen --key-file=/dev/mapper/cryptkey "${DISK}4" cryptswap
mkswap -L swap /dev/mapper/cryptswap
swapon /dev/disk/by-label/swap

cryptsetup luksOpen --key-file=/dev/mapper/cryptkey "${DISK}5" cryptroot
mkfs.ext4 -L nixos /dev/mapper/cryptroot
mount /dev/disk/by-label/nixos /mnt

mkfs.vfat -n efi "${DISK}2"
mkdir /mnt/boot
mount /dev/disk/by-label/efi /mnt/boot

nixos-generate-config --root /mnt

curl -Sso /mnt/etc/nixos/luks-devices-configuration.nix \
  https://raw.githubusercontent.com/Pamplemousse/laptop/master/etc/nixos/luks-devices-configuration.nix
curl -Sso /mnt/etc/nixos/packages.nix \
  https://raw.githubusercontent.com/Pamplemousse/laptop/master/etc/nixos/packages.nix

sed -i -e "s/DISK/${DISK}/g" /mnt/etc/nixos/luks-devices-configuration.nix
curl -Sso /mnt/etc/nixos/configuration.nix \
  https://raw.githubusercontent.com/Pamplemousse/laptop/master/etc/nixos/configuration.nix

nixos-install
