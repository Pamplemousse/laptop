#!/usr/bin/env bash

# Work on a copy of the configuration, trimmed from hardware specific content.
cp ./etc/nixos/configuration.nix ./etc/nixos/.configuration.nix
patch ./etc/nixos/.configuration.nix tests/patches/hardwareless_configuration.patch

if [ -n "$GITHUB_WORKSPACE" ]; then
  # GitHub Actions are run with a limited amount of space.
  patch ./etc/nixos/.configuration.nix tests/patches/lighter_configuration.patch

  # Needs to specify where to find `nixos-generate` during GitHub Actions.
  if ! nixos-generate --help >/dev/null 2>&1; then
      export PATH=$GITHUB_WORKSPACE/nixos-generators:$PATH
  fi
fi

nixos-generate -f vm -c ./etc/nixos/.configuration.nix
