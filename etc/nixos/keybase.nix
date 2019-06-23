{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    keybase
    keybase-gui
  ];

  services = {
    keybase.enable = true;
    kbfs.enable = true;
  };
}
