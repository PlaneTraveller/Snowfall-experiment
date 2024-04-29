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
      enable = true;

    };

  };
}
