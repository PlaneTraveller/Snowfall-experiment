{ options, config, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.system.xkb;
in {
  options.literacy.system.xkb = with types; {
    enable = mkBoolOpt false "Whether or not to configure xkb.";
  };

  config = mkIf cfg.enable {
    console.useXkbConfig = true;
    services.xserver = {
      layout = "us";
      xkbOptions = "caps:escape";
    };
  };
}
