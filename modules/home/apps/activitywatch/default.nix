{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.apps.activitywatch;
in {
  options.literacy.apps.activitywatch = with types; {
    enable = mkBoolOpt false "Enable or disable activitywatch";
  };

  config = mkIf cfg.enable {
    services.activitywatch = {
      package = pkgs.activitywatch;
      enable = true;
      # https://nix-community.github.io/home-manager/options.xhtml#opt-services.activitywatch.watchers
      # https://docs.activitywatch.net/en/latest/configuration.html
      watchers = {
        aw-watcher-afk = {
          package = pkgs.activitywatch;
          settings = {
            poll_time = 5;
            timeout = 180;
          };
        };

        aw-watcher-window = {
          package = pkgs.activitywatch;
          settings = {
            exclude_title = false;
            poll_time = 1;
          };
        };
      };
    };
  };
}
