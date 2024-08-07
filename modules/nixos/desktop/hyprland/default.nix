{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.desktop.hyprland;
in {
  options.literacy.desktop.plasma6 = with types; {
    enable = mkBoolOpt false "Enable or disable hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland.enable = true;

    #== Home Manager
    home = {
      wayland = {
        windowManager = {
          hyprland = {
            enable = true;
            xwayland.enable = true;
            settings = {

            };
            plugins = [ ];
          };
        };
      };
    };
  };
}
