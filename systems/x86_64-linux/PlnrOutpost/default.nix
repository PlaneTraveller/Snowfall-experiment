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
      audio = enabled;
      bluetooth = enabled;
      battery = enabled;

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
          "TCP" = [ 80 443 8080 7777 58101 25565 21073 20170 20171 21072 ];
          "UDP" = [ 24642 41641 ];
        };

        proxy = {
          # default = "http://pi.aie.moe:7890";
          # default = "http://127.0.0.1:7890";
          # httpsProxy = "socks5://pi.aie.moe:7891";
          # default = "http://127.0.0.1:20172";
          # noProxy = "127.0.0.1";
        };

      };

      #== Fonts
      fonts = { enable = true; };

    };

    #=============================================================
    #== User
    user = { defaultShell = "fish"; };

    #=============================================================
    #== Services
    services = {
      v2raya = enabled;
      printing = enabled;

      syncthing = {
        enable = true;
        devices = {
          # "PlanarOutpost" = {
          #   id =
          #     "DKU7AVM-OGT2QDY-LUJF6PQ-UJ25FJW-MWEPKNQ-BXMKOJR-7EYDGD5-6RCE3QV";
          # };
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
    desktop = { plasma6 = enabled; };

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
    # libsForQt5.bismuth
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
    # wineWowPackages.stable
    # python311Packages.mne-python
    neovim
    # activitywatch
    # temurin-bin-18
    # tailscale
    # miniserve
    cockatrice
    # gcc-unwrapped
    # direnv
    just

    python311Packages.python-lsp-server
    alacritty
    forge-mtg
    gimp
  ];

  # # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # # Enable the KDE Plasma Desktop Environment.
  # services.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
  # services.lorri.enable = true;
  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs29-pgtk;
  # };

  services.tailscale.enable = false;
  virtualisation.docker = enabled;
  # security.pam.sshAgentAuth.enable = true;
  programs.ssh.startAgent = true;
  services.gnome.gnome-keyring.enable = true;

  # Enable incoming ssh
  services.openssh = {
    enable = false;
    openFirewall = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };

  };

  programs.nh = {
    enable = true;
    clean.enable = false;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/planetraveller/Desktop/NixRice/Snowfall-experiment";
  };

  # ======================== DO NOT CHANGE THIS ========================
  system.stateVersion = "23.11";
  # ======================== DO NOT CHANGE THIS ========================
}
