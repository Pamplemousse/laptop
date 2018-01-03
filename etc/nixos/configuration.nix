{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.enableCryptodisk = true;

  networking.hostName = "w"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr-bepo";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    chromium
    docker
    evince
    firefox
    gcc
    gdb
    git
    gnumake
    keepassx-community
    keybase
    keybase-gui
    kbfs
    libreoffice
    tmux
    vim
    vlc
  ];

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "fr";
    xkbVariant = "bepo";
  };

  # services.xserver.xkbOptions = "eurosign:e";

  # Enable the Gnome Desktop Environment.
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.desktopManager.gdm.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.pamplemousse = {
    isNormalUser = true;
    description = "Xavier Maso";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    home = "/home/pamplemousse";
    shell = pkgs.zsh;
    uid = 1000;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";
}
