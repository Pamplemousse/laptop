{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./luks-devices-configuration.nix

      # Include packages with their related configuration
      ./docker.nix
      ./irssi.nix
      ./keybase.nix
      ./usbguard.nix
      ./screenlocker.nix
      ./zathura.nix

      ./packages.nix
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  console = {
    font = "Fura Code Regular Nerd Font Complete Mono";
    keyMap = "fr-bepo";
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      nerdfonts
    ];
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  networking.hostName = "w";
  networking.networkmanager.enable = true;

  services.logind.extraConfig = "
    HandleLidSwitch=suspend
    HandleLidSwitchDocked=suspend
  ";

  services.xserver = {
    desktopManager.gnome3.enable = true;
    displayManager.gdm.enable = true;
    enable = true;
    layout = "fr";
    xkbVariant = "bepo";
  };

  system.stateVersion = "19.03";
  system.autoUpgrade.enable = true;

  time.timeZone = "Europe/Amsterdam";

  users.extraUsers.pamplemousse = {
    description = "Xavier Maso";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    isNormalUser = true;
    shell = pkgs.zsh;
    uid = 1000;
  };

  virtualisation = {
    virtualbox.host.enable = true;
  };
}
