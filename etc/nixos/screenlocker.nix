{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    i3lock
    xss-lock
  ];

  programs.xss-lock.enable = true;

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xss-lock}/bin/xss-lock -- ${pkgs.i3lock}/bin/i3lock -c 49938e &
  '';
}
