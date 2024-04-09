# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, ... }:

{
  # imports = [ # Include the results of the hardware scan.
  #   ./hardware-configuration.nix
  # ];

  # nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # nix.settings.substituters = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  # nix.settings.substituters = lib.mkForce [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "PlanarSphere"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://pi.aie.moe:7890";
  # networking.firewall.enable = false;
  # networking.firewall.allowedTCPPorts = [ 80 443 8080 7777 58101 25565 22000 ];
  # networking.firewall.allowedTCPPortRanges = [
  #   {
  #     from = 4000;
  #     to = 4007;
  #   }
  #   {
  #     from = 8000;
  #     to = 8010;
  #   }
  # ];

  # networking.firewall.allowedUDPPorts = [ 24642 ];
  # # networking.proxy.default = "http://pi.aie.moe";
  # # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # # Enable networking
  # networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Set your time zone.
  # time.timeZone = "Asia/Shanghai";

  # # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";

  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "zh_CN.UTF-8";
  #   LC_IDENTIFICATION = "zh_CN.UTF-8";
  #   LC_MEASUREMENT = "zh_CN.UTF-8";
  #   LC_MONETARY = "zh_CN.UTF-8";
  #   LC_NAME = "zh_CN.UTF-8";
  #   LC_NUMERIC = "zh_CN.UTF-8";
  #   LC_PAPER = "zh_CN.UTF-8";
  #   LC_TELEPHONE = "zh_CN.UTF-8";
  #   LC_TIME = "zh_CN.UTF-8";
  # };

  # # Nvidia config
  # hardware.opengl = {
  #   enable = true;
  #   driSupport = true;
  #   driSupport32Bit = true;
  # };

  # services.xserver.videoDrivers = ["nvidia"];

  # hardware.nvidia = {
  #   modesetting.enable = true;
  #   powerManagement.enable = true;
  #   powerManagement.finegrained = false;
  #   open = false;
  #   nvidiaSettings = true;
  #   package = config.boot.kernelPackages.nvidiaPackages.stable;
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    # xkbVariant = "us";
    # xkbVariant = "colemak";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.planetraveller = {
    isNormalUser = true;
    description = "Huayu";
    extraGroups = [ "networkmanager" "wheel" ];
    # shell = pkgs.fish;
    packages = with pkgs; [
      firefox
      git
      emacs29
      fzf
      thunderbird
      libsForQt5.bismuth
      prismlauncher
      syncthing
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
      proxychains
      cider
      uxplay
      godot_4
      # steam-tui
      steamPackages.steamcmd
      solaar
      # logiops
      onlyoffice-bin
      lutris
      # discord
      v2raya
      wineWowPackages.stable
      # python311Packages.mne-python
      neovim
      activitywatch
      temurin-bin-18
      # tailscale
      miniserve
      cockatrice

    ];
  };

  services.tailscale.enable = false;
  services = {
    syncthing = {
      enable = true;
      user = "planetraveller";
      dataDir = "/home/planetraveller";
      configDir = "/home/planetraveller/.config/syncthing";
      overrideDevices =
        true; # overrides any devices added or deleted through the WebUI
      overrideFolders =
        true; # overrides any folders added or deleted through the WebUI
      guiAddress = "127.0.0.1:8384";
      settings = {
        devices = {
          "PlanarOutpost" = {
            id =
              "DKU7AVM-OGT2QDY-LUJF6PQ-UJ25FJW-MWEPKNQ-BXMKOJR-7EYDGD5-6RCE3QV";
          };
        };
        folders = {
          "Desktop" = {
            path = "~/Desktop";
            devices = [ "PlanarOutpost" ];
            ignorePerms = true;
            versioning = {
              type = "staggered";
              params = {
                cleanInterval = "3600";
                maxAge = "5260000";
              };
            };
          };
          "Archive" = {
            path = "~/Archive";
            devices = [ "PlanarOutpost" ];
            ignorePerms = true;
            versioning = {
              type = "simple";
              params = { keep = "10"; };
            };
          };
          "Literacy" = {
            enabled = false;
            path = "~/Literacy";
            devices = [ "PlanarOutpost" ];
            ignorePerms = true;
            versioning = {
              type = "staggered";
              params = {
                cleanInterval = "3600";
                maxAge = "15552000";
              };
            };
          };
          # "Play" = {
          #   path = "~/Play";
          #   devices = [ "PlanarOutpost" ];
          #   ignorePerms = true;
          #   versioning = {
          #     type = "simple";
          #     params = {
          #       keep = "10";
          #     };
          #   };
          # };
          "Aesthetics" = {
            path = "~/Aesthetics";
            devices = [ "PlanarOutpost" ];
            ignorePerms = true;
            versioning = {
              type = "simple";
              params = { keep = "10"; };
            };
          };
        };
      };
    };
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs;
      [
        # fcitx5-mozc
        # fcitx5-gtk
        # fcitx5-rime
        fcitx5-chinese-addons
      ];
    # enabled = "ibus";
    # ibus.engines = with pkgs.ibus-engines; [
    #   libpinyin
    #   rime
    # ];
  };

  services.v2raya.enable = false;

  # systemd.user.services.clash = {
  #   enable = true;
  #   wantedBy = [ "default.target" ];
  #   description = "Clash-meta Daemon";
  #   serviceConfig = {
  #     ExecStart = "/etc/profiles/per-user/planetraveller/bin/clash-meta";
  #     Restart = "on-abort";
  #   };
  # };

  # systemd.user.services.activitywatch = {
  #   enable = true;
  #   wantedBy = [ "default.target" ];
  #   description = "Activity Watch";
  #   serviceConfig = {
  #     ExecStart = "/etc/profiles/per-user/planetraveller/bin/aw-qt";
  #     Restart = "on-abort";
  #   };
  # };

  # systemd.user.services.logitech = {
  #   enable = true;
  #   wantedBy = [ "default.target" ];
  #   description = "Logitech Configuration Daemon";
  #   serviceConfig = {
  #     ExecStart = "/etc/profiles/per-user/planetraveller/bin/logid -c /home/planetraveller/.config/logid/logid.cfg";
  #     Restart = "on-abort";
  #   };
  # };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      source-han-sans
      source-code-pro
      hack-font
      jetbrains-mono
      ibm-plex
      overpass
      emacs-all-the-icons-fonts
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.proxychains = {
    enable = true;
    proxies = {
      myproxy = {
        type = "socks5";
        host = "127.0.0.1";
        port = 7891;
      };
    };
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs29;
  };

  # Allow unfree packages
  # nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11";
  # Did you read the comment?

}
