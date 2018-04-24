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

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    androidsdk
    ant
    bash
    chromium
    ctags
    docker
    evince
    file
    firefox
    gcc
    gdb
    git
    gnumake
    irssi
    keepassx-community
    keybase
    keybase-gui
    kbfs
    libreoffice
    ntfs3g
    openjdk
    perlPackages.LWP
    perlPackages.LWPProtocolHttps
    perlPackages.NetSSLeay
    skype
    syncthing
    tcpdump
    tmux
    tree
    usbguard
    vim
    vlc
    wireshark
    youtube-dl
  ];

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr-bepo";
    defaultLocale = "en_US.UTF-8";
  };

  networking.hostName = "w";
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

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

  system.stateVersion = "17.09";
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
