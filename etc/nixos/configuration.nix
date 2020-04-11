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

  hardware.nitrokey.enable = true;
  hardware.u2f.enable = true;

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  networking.hostName = "w";
  networking.networkmanager.enable = true;

  security.pam = {
    services = {
      i3lock.u2fAuth = true;
      login.u2fAuth = true;
      lightdm.u2fAuth = true;
    };

    u2f = {
      authFile = /home/pamplemousse/.config/u2f_keys;
      enable = true;
      control = "sufficient";
    };
  };

  services.logind.extraConfig = "
    HandleLidSwitch=suspend
    HandleLidSwitchDocked=suspend
  ";

  services.udev.extraRules = ''
    ACTION=="remove", ATTRS{idVendor}=="20a0", ATTRS{idProduct}=="4287", RUN+="${pkgs.systemd}/bin/loginctl lock-sessions"
  '';

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
    extraGroups = [ "wheel" "networkmanager" "nitrokey" "docker" ];
    isNormalUser = true;
    shell = pkgs.zsh;
    uid = 1000;
  };

  virtualisation = {
    virtualbox.host.enable = true;
  };
}
