{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    usbguard
  ];

  services.usbguard = {
    enable = true;
    IPCAllowedUsers = [ "root" "pamplemousse" ];
    ruleFile = "/home/pamplemousse/.config/usbguard/rules.conf";
  };
}
