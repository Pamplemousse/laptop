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

## lint

```bash
shellcheck -e SC1090 install.sh setup.sh
```

## help

When in trouble, have a look at:

  * [My blog post](https://blog.xaviermaso.com/2019/02/28/NixOS-on-a-Dell-XPS15-9560.html)
  * [Installation Guide](https://nixos.wiki/wiki/NixOS_Installation_Guide)
