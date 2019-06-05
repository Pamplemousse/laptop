{ pkgs, ... }:

{
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

  nixpkgs.config.allowUnfree = true;
}
