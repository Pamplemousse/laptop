{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    afl
    bash
    binutils
    byzanz
    chromium
    ctags
    exif
    file
    firefox
    gcc
    gdb
    gimp
    git
    gnumake
    gradle
    keepassx-community
    libreoffice
    neovim
    ntfs3g
    oh-my-zsh
    openjdk
    shellcheck
    skype
    ssss
    syncthing
    tcpdump
    tmux
    tree
    vlc
    wireshark
    xorg.xkbcomp
    xrectsel
    youtube-dl
    z3
    zoom-us
  ];

  nixpkgs.config.allowUnfree = true;
}
