# { pkgs, lib, ... }:
{ pkgs, config, lib, modulesPath, inputs, ... }:

with lib;
with lib.literacy; {
  imports = [ ./hardware-configuration.nix ./configuration.nix ];
  # networking.hostName = "PlanarSphere";

  # Enable Bootloader
  # system.boot.efi.enable = true;
  # system.boot.bios.enable = true;

  # system.battery.enable = true; # Only for laptops, they will still work without it, just improves battery life

  # suites.common.enable = true; # Enables the basics, like audio, networking, ssh, etc.
  # test.old.enable = true

  # suites.desktop.enable = true;
  # suites.gaming.enable = true;

  hardware.nvidia = enabled;

  system = {
    #== Misc
    boot.efi = enabled;
    locale = enabled;
    time = enabled;

    #== Nix
    nix = {
      default-substituter = {
        url = "https://mirror.sjtu.edu.cn/nix-channels/store";
        key = "";
      };
      extra-substituters = {
        "https://cache.nixos.org" = {
          key =
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=";
        };
      };
    };

    #== Networking
    networking = {
      enable = true;
      enableFirewall = true;

      openPorts = {
        "TCP" = [ 80 443 8080 7777 58101 25565 22000 ];
        "UDP" = [ 24642 ];
      };
      openPortRanges = {
        "TCP" = [
          {
            from = 4000;
            to = 4007;
          }
          {
            from = 8000;
            to = 8010;
          }
        ];
        "UDP" = [ ];
      };

      proxy = {
        httpProxy = "http://pi.aie.moe:7890";
        httpsProxy = "socks5://pi.aie.moe:7891";
      };

    };

  };

  environment.systemPackages = with pkgs;
    [
      # Any particular packages only for this host
    ];

  # ======================== DO NOT CHANGE THIS ========================
  system.stateVersion = "23.11";
  # ======================== DO NOT CHANGE THIS ========================
}
