{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    bitlbee
    irssi
    perlPackages.LWP
    perlPackages.LWPProtocolHttps
    perlPackages.NetSSLeay
    purple-hangouts
  ];

  nixpkgs.config.bitlbee.enableLibPurple = true;

  services = {
    bitlbee = {
      enable = true;
      libpurple_plugins = [ pkgs.purple-hangouts ];
    };
  };
}
