{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.desktop.stylix;
in {
  options.literacy.desktop.stylix = with types; {
    enable = mkBoolOpt false "Enable or disable stylix";
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;
      image = ./wallpapers/rain_world1.png;
      base16Scheme =
        "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";

      polarity = "dark";
      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";

      };
    };
  };
}
