{ pkgs, ... }:

{
  nix = {
    autoOptimiseStore = true;

    extraOptions = ''
      # GC as soon as there is less than 100MiB left
      min-free = ${toString (100 * 1024 * 1024)}
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
