{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    docker
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
  };
}
