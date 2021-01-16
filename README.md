# laptop

Setup a work environment on my laptop using NixOS.

  * **write down necessary data and secrets**:
    - "secret dotfiles" repository location
    - GitHub personal access token
    - LUKS key to decrypt external hard disk drive
    - LUKS key to decrypt backup hard disk drive
  * download NixOS iso: [nixos.org/nixos/download.html](https://nixos.org/nixos/download.html)
  * setup usb key: `sudo dd bs=4M if=~/Downloads/nixos.iso of=/dev/sdb`
  * boot on it

```bash
loadkeys fr-bepo
nmtui
curl -Ss https://raw.githubusercontent.com/Pamplemousse/laptop/master/install.sh > install.sh
sh install.sh

# reboot, login with the root user
passwd pamplemousse
passwd -l root

# logout, login with pamplemousse
curl -Ss https://raw.githubusercontent.com/Pamplemousse/laptop/master/setup.sh > setup.sh
sh setup.sh
```

## lint

```bash
# shell scripts
shellcheck -e SC1090 install.sh setup.sh tests/test_build.sh
# nix expressions
nixpkgs-fmt --check etc/nixos/*.nix
```

## help

When in trouble, have a look at:

  * [My blog post](https://blog.xaviermaso.com/2019/02/28/NixOS-on-a-Dell-XPS15-9560.html)
  * [Installation Guide](https://nixos.wiki/wiki/NixOS_Installation_Guide)
