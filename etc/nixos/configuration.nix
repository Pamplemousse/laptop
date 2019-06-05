{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./luks-devices-configuration.nix

      # Include packages with their related configuration
      ./packages.nix
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      nerdfonts
    ];
  };

  i18n = {
    consoleFont = "Fura Code Regular Nerd Font Complete Mono";
    consoleKeyMap = "fr-bepo";
    defaultLocale = "en_US.UTF-8";
  };

  networking.hostName = "w";
  networking.networkmanager.enable = true;

  nixpkgs.config.bitlbee.enableLibPurple = true;
  nixpkgs.config.zathura.useMupdf = true;

  services.bitlbee = {
    enable = true;
    libpurple_plugins = [ pkgs.purple-hangouts ];
  };

  services.keybase.enable = true;
  services.kbfs.enable = true;

  services.logind.extraConfig = "
    HandleLidSwitch=suspend
    HandleLidSwitchDocked=suspend
  ";

  services.usbguard = {
    enable = true;
    IPCAllowedUsers = [ "root" "pamplemousse" ];
  };

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
    home = "/home/pamplemousse";
    isNormalUser = true;
    shell = pkgs.zsh;
    uid = 1000;
  };

  virtualisation = {
    docker.enable = true;
    docker.enableOnBoot = true;

    virtualbox.host.enable = true;
  };
}
