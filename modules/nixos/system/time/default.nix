{ options, config, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.system.time;
in {
  options.system.time = with types; {
    enable =
      mkBoolOpt false "Whether or not to configure timezone information.";
    timeZone = mkOpt str "Asia/Shanghai" "Timezone";
  };

  config = mkIf cfg.enable { time.timeZone = cfg.timeZone; };
}
