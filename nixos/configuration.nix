{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./commandline.nix
    ./desktop.nix
    ./network.nix
  ];

  system.stateVersion = "19.03";

  nixpkgs.config.allowUnfree = true;

  boot = {
    tmpOnTmpfs = true;
    kernelPackages = pkgs.linuxPackages_latest_hardened;

    loader = {
      grub.enable = true;
      grub.version = 2;
      grub.device = "/dev/vda";
      #timeout = 0;
      #systemd-boot.enable = true;
      #efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    trackpoint = {
      emulateWheel = true;
      speed = 140; # default: 97
    };

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
  };
}
