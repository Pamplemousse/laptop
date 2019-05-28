{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./luks-devices-configuration.nix
    ];

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.enable = true;

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    afl
    bash
    binutils
    bitlbee
    byzanz
    chromium
    ctags
    docker
    exif
    file
    firefox
    gcc
    gdb
    gimp
    git
    gnumake
    gradle
    irssi
    keepassx-community
    keybase
    keybase-gui
    kbfs
    libreoffice
    ntfs3g
    oh-my-zsh
    openjdk
    perlPackages.LWP
    perlPackages.LWPProtocolHttps
    perlPackages.NetSSLeay
    purple-hangouts
    shellcheck
    skype
    ssss
    syncthing
    tcpdump
    tmux
    tree
    usbguard
    vim
    vlc
    wireshark
    xrectsel
    youtube-dl
    z3
    zathura
    zoom-us
  ];

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr-bepo";
    defaultLocale = "en_US.UTF-8";
  };

  networking.hostName = "w";
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;
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
