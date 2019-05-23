# This file contain packages which are nessescary for making the desktop environment function
{ config, pkgs, writeScript, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      openssh
    ];
  };

  networking = {
    # networkmanager.enable = true;
    # nameservers = [
    #   "1.1.1.1"
    #   "1.0.0.1"
    # ];
   # extraHosts = ''
   #   127.0.0.1 demo.localhost'';
    networkmanager = {
      enable = true;
    };

    hostName = "xps13";
    firewall = {
      enable = true;
      allowPing = false;
      allowedTCPPorts = [3389];
    };
  };
}
