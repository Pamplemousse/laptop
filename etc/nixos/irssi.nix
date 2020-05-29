{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    irssi
    perlPackages.LWP
    perlPackages.LWPProtocolHttps
    perlPackages.NetSSLeay
  ];
}
