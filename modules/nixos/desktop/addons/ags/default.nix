{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.desktop.addons.ags;
in {
  options.literacy.desktop.addons.ags = with types; {
    enable = mkBoolOpt false "Enable or disable ags";
  };

  config = mkIf cfg.enable {

    #== Home Manager
    literacy.home = {
      extraOptions = {
        packages = with pkgs; [
          bun
          swww
          brightnessctl
          slurp
          wl-clipboard
          swappy
          pavucontrol
          networkmanager
        ];

      };
    };

    environment.systemPackages = with pkgs; [ ];

  };
}
