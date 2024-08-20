{ pkgs, config, lib, modulesPath, inputs, ... }:

with lib;
with lib.literacy; {
  imports = [
    ./hardware-configuration.nix
    # ./configuration.nix
  ];

  literacy = {
    #=============================================================
    #== Hardware
    hardware = {
      nvidia = enabled;
      audio = enabled;
      bluetooth = enabled;

    };

    #=============================================================
    #== System
    system = {
      #== Misc
      boot.efi = enabled;
      locale = enabled;
      time = enabled;
      i18n = enabled;

      #== Nix
      nix = {
        default-substituter = {
          url = "https://mirror.sjtu.edu.cn/nix-channels/store";
          key = "";
        };
        extra-substituters = {
          "https://mirrors.ustc.edu.cn/nix-channels/store".key = "";
          "https://nix-community.cachix.org".key =
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=";
          "https://cache.nixos.org".key =
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
        };
      };

      #== Networking
      networking = {
        enable = true;
        enableFirewall = true;

        openPorts = {
          "TCP" = [ 80 443 8080 7777 58101 25565 21073 20170 20171 21072 6286 ];
          "UDP" = [ 24642 6286 41641 ];
        };

        proxy = {
          # default = "http://pi.aie.moe:7890";
          # default = "http://127.0.0.1:7890";
          # httpsProxy = "socks5://pi.aie.moe:7891";
          # default = "http://127.0.0.1:20172";
          noProxy = "127.0.0.1";
        };

      };

      #== Fonts
      fonts = { enable = true; };

    };

    #=============================================================
    #== Services
    services = {
      v2raya = enabled;
      printing = enabled;

      syncthing = {
        enable = true;
        devices = {
          "PlanarOutpost" = {
            id =
              "DKU7AVM-OGT2QDY-LUJF6PQ-UJ25FJW-MWEPKNQ-BXMKOJR-7EYDGD5-6RCE3QV";
          };
        };
      };

    };

    #=============================================================
    #== Apps
    apps = { steam = enabled; };

    #=============================================================
    #== System
    cli = {
      proxychains = enabled;

    };

    #=============================================================
    #== Desktop
    # desktop = { plasma6 = enabled; };

    #=============================================================
    #== Others
  };

  #=============================================================
  #== Temporary Config
  environment.systemPackages = with pkgs;
    [
      # Any particular packages only for this host
    ];

  literacy.user.extraOptions.packages = with pkgs; [
    wget
    firefox
    # git
    # emacs29
    fzf
    # libsForQt5.polonium
    thunderbird
    libsForQt5.bismuth
    prismlauncher
    # syncthing
    qq
    # clash-meta
    nodejs
    cmake
    gnumake
    python3
    python311Packages.epc
    python311Packages.sexpdata
    python311Packages.six
    python311Packages.pynput
    python311Packages.inflect
    python311Packages.pyqt6
    python311Packages.pyqt6-sip
    telegram-desktop
    nixfmt-classic
    nil
    texliveFull
    gh
    libreoffice
    # proxychains
    cider
    uxplay
    godot_4
    # steam-tui
    # steamPackages.steamcmd
    solaar
    # logiops
    onlyoffice-bin
    lutris
    discord
    # v2raya
    wineWowPackages.stable
    # python311Packages.mne-python
    neovim
    # activitywatch
    # temurin-bin-18
    # tailscale
    miniserve
    cockatrice
    gcc-unwrapped
    # direnv
    just

    python311Packages.python-lsp-server
    alacritty
    forge-mtg
    gimp
    ffmpeg
    pandoc
    pdftk
    imagemagick
    poppler
    poppler_utils
    via
    vial
    ags
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.udev.extraRules = ''
  #   KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  # '';
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.lorri.enable = true;
  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs29-pgtk;
  # };

  services.tailscale.enable = false;

  services.openssh = {
    enable = true;
    ports = [ 6286 ];
    settings = {
      PasswordAuthentication = false;
      AllowUsers = null;
    };

  };

  users.users."planetraveller".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL2ZJ/4O2wgBP9PTUlOrnhPolh4xQclVqH0fm9TQbdPp why123jj@126.com"
  ];

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      "proxies" = { "http-proxy" = "127.0.0.1:20171"; };

    };

  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/planetraveller/Desktop/NixRice/Snowfall-experiment";
  };

  # ======================== DO NOT CHANGE THIS ========================
  system.stateVersion = "23.11";
  # ======================== DO NOT CHANGE THIS ========================
}
