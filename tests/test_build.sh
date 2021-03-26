#!/usr/bin/env bash

# Needs to specify where to find `nixos-generate` during GitHub Actions.
if ! nixos-generate --help >/dev/null 2>&1; then
  if [ -n "$GITHUB_WORKSPACE" ]; then
    export PATH=$GITHUB_WORKSPACE/nixos-generators:$PATH
  fi
fi

# Work on a copy of the configuration, trimmed from hardware specific content.
cp ./etc/nixos/configuration.nix ./etc/nixos/.configuration.nix
sed -i -e "s,HARDWARE,,g" ./etc/nixos/.configuration.nix
sed -i -e "s,./hardware-configuration.nix,,g" ./etc/nixos/.configuration.nix
sed -i -e "s,./luks-devices-configuration.nix,,g" ./etc/nixos/.configuration.nix

nixos-generate -f vm -c ./etc/nixos/.configuration.nix
