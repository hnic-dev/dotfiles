{ config, pkgs, ... }:
{
  environment = {
    shells = [ pkgs.bash ];


    systemPackages = with pkgs; [
      gnupg                # encryption tool
      git                  # version control
      exiftool             # reading image fileheaders
      file                 # file inspection
      curl                 # http interaction
      tree                 # directory tree inspector
      ripgrep              # alternative to grep
      #fzf                  # fuzzy matcher used for reverse bash search
      htop                 # performance inspection
      #powertop             # battery drain inspection
      #psmisc               # needed for `pkill`
      pandoc               # document converter
      usbutils             # `lsusb` tool used for displaying usb information
      docker_compose       # easy and simple docker orchestration
      imagemagick          # image resizing and manipulation
      gnumake
      traceroute
      lsof
      nmap
      #hugo                 # website generator

      # development
      #sqlite  # small file-oriented sql database
      go      # golang programming language
      dep     # depedency manager for golang
      gotools # helper cli for golang (auto importing and more)
      golangci-lint

      # extraction + compression
      unrar
      zip
      unzip
      dtrx
      pv
      p7zip
    ];
  };
}
