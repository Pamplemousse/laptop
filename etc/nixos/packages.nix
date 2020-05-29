{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    bash
    binutils
    byzanz
    chromium
    ctags
    exif
    file
    firefox
    gimp
    git
    keepassx-community
    libreoffice
    neovim
    ntfs3g
    oh-my-zsh
    riot-desktop
    shellcheck
    signal
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
    zoom-us
  ];

  nixpkgs.config.allowUnfree = true;
}
