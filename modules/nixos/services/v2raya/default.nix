{ options, config, pkgs, lib, ... }:

with lib;
with lib.literacy;
let cfg = config.literacy.services.v2raya;
in {
  options.literacy.services.v2raya = with types; {
    enable = mkBoolOpt false "Whether or not to configure v2raya.";
  };

  config = mkIf cfg.enable { services.v2raya.enable = true; };
}
