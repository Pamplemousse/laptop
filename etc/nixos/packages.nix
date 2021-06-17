{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    autojump
    bash
    bat
    binutils
    byzanz
    cachix
    du-dust
    exif
    file
    firefox
    gimp
    git
    keepassx-community
    libreoffice
    lightlocker
    lsd
    manpages
    neovim
    nix-index
    ntfs3g
    oh-my-zsh
    playerctl
    ptags
    element-desktop
    shellcheck
    signal-desktop
    skype
    ssss
    syncthing
    tcpdump
    tmux
    tree
    ungoogled-chromium
    vlc
    wireshark
    xclip
    xorg.xkbcomp
    xrectsel
    youtube-dl
    zoom-us
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;
}
