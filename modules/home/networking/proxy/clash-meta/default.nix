{ options, config, lib, pkgs, ... }:
with lib;
with lib.literacy;
let cfg = config.networking.proxy.clash-meta;
in {
  options.networking.proxy.clash-meta = with types; {
    enable = mkBoolOpt false "Enable or disable clash-meta";

  };

  config = mkIf cfg.enable {
    home = { packages = with pkgs; [ clash-meta ]; };

    home.configFile."clash/config.yaml".source = ./config.yaml;

    # home.persist.directories = [ ".config/clash-verge" ];

    systemd.user.services.clash-meta = {
      Unit = { description = "Clash-meta Daemon"; };
      Install = { WantedBy = [ "default.target" ]; };
      Service = {
        ExecStart = "${pkgs.writeShellScript "clash-meta" ''
          #!/run/current-system/sw/bin/bash
          ${pkgs.clash-meta}/bin/clash-meta
        ''}";

      };

    };

  };
}
