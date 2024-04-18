{ options, config, pkgs, lib, ... }:

with lib;
with lib.literacy;
let cfg = config.literacy.services.tailscale;
in {
  options.literacy.services.tailscale = with types; {
    enable = mkBoolOpt false "Whether or not to configure tailscale.";
  };

  config = mkIf cfg.enable { services.tailscale.enable = false; };
}
