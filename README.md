# laptop

Setup a work environment on my laptop using NixOS.

```bash
# download NixOS iso, boot on it
loadkeys fr-bepo
curl -Ss https://raw.githubusercontent.com/Pamplemousse/laptop/master/install.sh | sh

# reboot, login with the root user
passwd pamplemousse
passwd -l root

# logout, login with pamplemousse
curl -Ss https://raw.githubusercontent.com/Pamplemousse/laptop/master/setup.sh | sh
```
