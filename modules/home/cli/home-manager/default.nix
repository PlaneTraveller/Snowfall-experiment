{ lib, config, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.literacy) enabled;

  cfg = config.cli.home-manager;
in {
  options.cli.home-manager = { enable = mkEnableOption "home-manager"; };

  config = mkIf cfg.enable { programs.home-manager = enabled; };
}
