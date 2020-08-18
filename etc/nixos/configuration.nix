{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      HARDWARE
      ./hardware-configuration.nix
      ./luks-devices-configuration.nix

      # Include packages with their related configuration
      ./docker.nix
      ./irssi.nix
      ./keybase.nix
      ./nix.nix
      ./usbguard.nix
      ./screenlocker.nix
      ./zathura.nix
      ./zsh.nix

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

  networking = {
    extraHosts = let
      hostsPath = https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts;
      hostsFile = builtins.fetchurl hostsPath;
    in builtins.readFile "${hostsFile}";

    hostName = "w";

    networkmanager.enable = true;

    # Save myself hours of internet-less debugging by leaving that commented:
    # `option edns0` in `/etc/resolv.conf` breaks DNS with old / consumer-grade routers;
    # See https://github.com/NixOS/nixpkgs/issues/24433 .
    # resolvconf.dnsExtensionMechanism = false;
  };

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
