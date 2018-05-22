# laptop

Setup a work environment on my laptop using NixOS.

  * download NixOS iso: [nixos.org/nixos/download.html](https://nixos.org/nixos/download.html)
  * setup usb key: `sudo dd bs=4M if=~/Downloads/nixos.iso of=/dev/sdb`
  * boot on it

```bash
loadkeys fr-bepo
nmtui
curl -Ss https://raw.githubusercontent.com/Pamplemousse/laptop/master/install.sh | sh

# reboot, login with the root user
passwd pamplemousse
passwd -l root

# logout, login with pamplemousse
curl -Ss https://raw.githubusercontent.com/Pamplemousse/laptop/master/setup.sh | sh
```

## help

When in trouble, have a look at:

  * [Installation Guide](https://nixos.wiki/wiki/NixOS_Installation_Guide)
  * [Full Disk Encryption](https://nixos.wiki/wiki/Full_Disk_Encryption)
