# This file contain packages which are nessescary for making the desktop environment function
{ config, pkgs, stdenv, ... }:
{
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  hardware.bluetooth.enable = true;

  time.timeZone = "America/Vancouver";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    consoleUseXkbConfig = true;
  };

  environment = {
    systemPackages = with pkgs; [
      xrdp
      i3
      # align comments with: 1gl# (in emacs)

      # appearance
      materia-theme
      papirus-icon-theme        # icon theme
      compton                   # compositor (shadows, transparency, etc.)
      dunst                     # notfication daemon
      #polybar                   # visual bar at desktop

      #tint2
      #cbatticon
      #volumeicon
      #xxkb
      lxappearance-gtk3

      # file managers
      gnome3.nautilus                  # file manager
      feh
      gvfs                      # needed for nautilus and thunar(?) to function

      # emacs
      vim
      emacs                     # best editor in the world
      languagetool              # advanced grammar tool
      libnotify                 # notification dependency for emacs

      # mail
      #thunderbird
      #TODO imap sync & astroid

      # disks
      gnome3.gnome-disk-utility # simple tool for formatting and partioning drives
      #gptfdisk                  # disk partitioner 
      #udiskie                   # auto

      imagemagick               # image manipulation from cli

      # screenshotting
      #scrot                     # take screenshots
      #nomacs                    # yet another image manipulation app

      # backlight
      xorg.xbacklight           # interact with backlighting

      # xfce plugins
      #xfce.xfce4-settings

      # applications
      wirelesstools             # basic wireless tools
      arandr                    # UI for xrandr (display controlling)
      gnome3.networkmanagerapplet
      ffmpeg
      networkmanagerapplet      # gui networking manager
      blueman                   # bluetooth manager
      firefox                   # web browsing
      chromium                  # web browser alternative
      gimp                      # user-friendly image manipulation
      inkscape                  # vector graphics manipulation
      gnome3.evince             # pdf viewer
      poppler_utils             # pdf editing tools
      remmina                   # rdp, vnc client
      vlc                       # video player
      kdenlive                  # video manipulation
      vagrant                   # orchestration of virtualbox
      libreoffice-fresh         # needed for opening microsoft products!
#      wireshark                 # traffic analysis
      xlibs.xmodmap             # swap buttons on the keyboard around
      transmission-gtk
    ];
  };

  fonts.fonts = with pkgs; [
    fira
    fira-mono
    fira-code
    fira-code-symbols
    # nerdfonts
    noto-fonts-cjk
    source-code-pro
    material-icons
    font-awesome-ttf
    inconsolata
    hack-font
    roboto
  ];

  security.polkit.enable = true;
  services = {
    #unclutter-xfixes.enable = true;
    urxvtd.enable = true;
    # needed for plank
    #dbus.packages = with pkgs; [ gnome3.dconf ];
    #bamf.enable = true;
    
    xserver = {
      enable = true;
     # layout = "us,dk";
     # xkbVariant = "altgr-intl";

     # videoDrivers = [ "intel" ];
     # libinput = {
     #   enable = true;
     # };

      #displayManager.slim = {
      displayManager.lightdm = {
        enable = true;
        #defaultUser = "nmadmin";
        #autoLogin = true;
      };

      desktopManager = {
        xterm.enable = false;
      };

      windowManager = {
        default = "i3";
	i3.enable = true;
      };
    };

    printing = {
    enable = true;
    drivers = with pkgs; [
        gutenprint
        foomatic-filters
      ];
    };

    autorandr.enable = true;
  };

  virtualisation = {
    virtualbox = {
      host.enable = true;
    };
    docker = {
      enable = true;
    };

  };

  programs = {
    bash.enableCompletion = true;
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  users.extraUsers.nmadmin = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "audio"
      "fuse"
      "pulse"
      "wheel"
      "wireshark"
      "docker"
      "davfs2"
    ];
    shell = pkgs.bash;
    uid = 1000;
  };
}
