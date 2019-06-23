{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    usbguard
  ];

  services.usbguard = {
    enable = true;
    IPCAllowedUsers = [ "root" "pamplemousse" ];
  };
}
