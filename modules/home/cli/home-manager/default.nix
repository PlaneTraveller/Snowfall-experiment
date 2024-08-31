{ lib, config, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  inherit (lib.literacy) enabled;

  cfg = config.literacy.cli.home-manager;
in {

  options.literacy.cli.home-manager = {
    enable = mkEnableOption "home-manager";
  };

  config = mkIf cfg.enable {
    programs.home-manager = {
      enable = true;
      # backFileExtension = ".bak";
    };
  };
}
