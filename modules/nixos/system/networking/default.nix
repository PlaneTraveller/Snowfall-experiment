{ options, config, pkgs, lib, ... }:

with lib;
with lib.literacy;
let cfg = config.literacy.system.networking;
in {

  #=============================================================
  #== Options
  options.literacy.system.networking = with types; {

    enable = mkBoolOpt false "Whether or not to enable networking support";
    hosts = mkOpt attrs { }
      (mdDoc "An attribute set to merge with `networking.hosts`");
    enableFirewall = mkBoolOpt true "Whether or not to enable default firewall";
    openPorts = mkOpt attrs {
      "TCP" = [ 80 443 8080 7777 58101 25565 22000 ];
      "UDP" = [ 24642 ];
    } (mdDoc "An attribute set of TCP and UDP allowed ports");
    openPortRanges = mkOpt attrs {
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
    } (mdDoc "An attribute set of TCP and UDP allowed port ranges");
    proxy = mkOpt attrs { } "An attribute set of global proxies";

  };

  #=============================================================
  #== Config
  config = mkIf cfg.enable {
    literacy.user.extraGroups = [ "networkmanager" ];

    networking = {
      hosts = {
        "127.0.0.1" = [ "local.test" ] ++ (cfg.hosts."127.0.0.1" or [ ]);
      } // cfg.hosts;
      networkmanager = {
        enable = true;
        dhcp = "internal";
      };

      #== Firewall settings
      firewall = {
        enable = cfg.enableFirewall;
        allowedTCPPorts = cfg.openPorts."TCP";
        allowedUDPPorts = cfg.openPorts."UDP";
        allowedTCPPortRanges = cfg.openPortRanges."TCP";
        allowedUDPPortRanges = cfg.openPortRanges."UDP";

      };

      #== Proxy settings
      proxy = cfg.proxy;

    };

    # Fixes an issue that normally causes nixos-rebuild to fail.
    # https://github.com/NixOS/nixpkgs/issues/180175
    # systemd.services.NetworkManager-wait-online.enable = false;
  };
}
