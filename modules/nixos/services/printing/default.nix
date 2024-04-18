{ options, config, pkgs, lib, ... }:

with lib;
with lib.literacy;
let cfg = config.literacy.services.printing;
in {
  options.literacy.services.printing = with types; {
    enable = mkBoolOpt false "Whether or not to configure printing support.";
  };

  config = mkIf cfg.enable { services.printing.enable = true; };
}
