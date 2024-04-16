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

  literacy = {
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
          "TCP" =
            [ 80 443 8080 7777 58101 25565 22000 21073 20170 20171 21072 ];
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
          # default = "http://pi.aie.moe:7890";
          # default = "http://127.0.0.1:7890";
          # httpsProxy = "socks5://pi.aie.moe:7891";
          default = "http://127.0.0.1:20172";
        };

      };

      #== Fonts
      fonts = { enable = true; };

    };
  };

  environment.systemPackages = with pkgs;
    [
      # Any particular packages only for this host
      # aria2
    ];

  virtualisation.docker = enabled;
  # services.aria2.enable = true

  # continue=true
  # always-resume=true
  # file-allocation=falloc
  # log-level=warn
  # max-connection-per-server=8
  # split=8
  # min-split-size=8M
  # allow-piece-length-change=true
  # on-download-complete=exit

  # ======================== DO NOT CHANGE THIS ========================
  system.stateVersion = "23.11";
  # ======================== DO NOT CHANGE THIS ========================
}
