{ config, pkgs, writeScript, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      openssh
    ];
  };

  networking = {
     networkmanager.enable = true;
     nameservers = [
       "1.1.1.1"
       "1.0.0.1"
     ];
    networkmanager = {
      enable = true;
    };

    hostName = "xps13";
    firewall = {
      enable = true;
      allowPing = false;
    };
  };
}
