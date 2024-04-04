{ options, config, lib, pkgs, ... }:
with lib;
with lib.literacy;
let cfg = config.networking.proxy.clash-verge;
in {
  options.networking.proxy.clash-verge = with types; {
    enable = mkBoolOpt false "Enable or disable clash-verge";
  };

  config = mkIf cfg.enable {
    # home.programs.clash-verge = {
    #   enable = true;
    #   package = pkgs.clash-verge;
    #   autoStart = true;
    #   tunMode = false;
    # };

    # home.configFile."clash-verge/config.yaml".source = ./config.yaml;

    # home.persist.directories = [ ".config/clash-verge" ];

    # systemd.user.services.clash = {
    #   enable = true;
    #   wantedBy = [ "default.target" ];
    #   description = "Clash-meta Daemon";
    #   serviceConfig = {
    #     ExecStart = "/etc/profiles/per-user/planetraveller/bin/clash-meta";
    #     Restart = "on-abort";
    #   };
    # };

  };
}
