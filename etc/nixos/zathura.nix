{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    zathura
  ];

  nixpkgs.config.zathura.useMupdf = true;
}
