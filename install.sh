#!/run/current-system/sw/bin/bash
#
# "Install" script
#

fdisk -l
read -r -p "Which disk shall we install everything on? (eg: /dev/sda) " DISK
RAM="$(free --giga | awk 'NR==2{print $2}')"
# 16MiB for header, 4MiB for the keyfile (random data)
CRYPTKEY_PARTITION_SIZE="20MiB"

# format and create partitions
sgdisk -og "$DISK"
sgdisk -n 1:2048:4095 -c 1:"BIOS boot partition" -t 1:ef02 "$DISK"
sgdisk -n 2:0:+550MiB -c 2:"EFI system partition" -t 2:ef00 "$DISK"
sgdisk -n 3:0:+"${CRYPTKEY_PARTITION_SIZE}" -c 3:"cryptsetup luks key" -t 3:8300 "$DISK"
sgdisk -n 4:0:+"${RAM}"GiB -c 4:"swap space (hibernation)" -t 4:8300 "$DISK"
sgdisk -n 5:0:"$(sgdisk -E "$DISK")" -c 5:"root filesystem" -t 5:8300 "$DISK"

cryptsetup luksFormat "${DISK}3"
cryptsetup luksOpen "${DISK}3" cryptkey

dd if=/dev/urandom of=/dev/null bs=1KB count=4MB iflag=count_bytes,fullblock

cryptsetup luksFormat --key-file=/dev/mapper/cryptkey "${DISK}4"

cryptsetup luksFormat --key-file=/dev/mapper/cryptkey "${DISK}5"
# add a "recovery" key in case `cryptkey` gets corrupted
cryptsetup luksAddKey --key-file=/dev/mapper/cryptkey "${DISK}5"

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

declare -a NIX_CONFIGURATION_FILES=(
  "luks-devices-configuration"

  "docker"
  "irssi"
  "keybase"
  "usbguard"
  "zathura"
  "zsh"

  "packages"
  "screenlocker"
)
for file in "${NIX_CONFIGURATION_FILES[@]}"
do
  curl -Sso /mnt/etc/nixos/"$file".nix \
    https://raw.githubusercontent.com/Pamplemousse/laptop/master/etc/nixos/"$file".nix
done

sed -i -e "s,DISK,${DISK},g" /mnt/etc/nixos/luks-devices-configuration.nix
curl -Sso /mnt/etc/nixos/configuration.nix \
  https://raw.githubusercontent.com/Pamplemousse/laptop/master/etc/nixos/configuration.nix

nixos-install
