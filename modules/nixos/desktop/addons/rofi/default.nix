{ options, config, lib, pkgs, namespace, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.desktop.addons.rofi;
in {
  options.literacy.desktop.addons.rofi = with types; {
    enable =
      mkBoolOpt false "Whether to enable Rofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ rofi ];

    literacy.home.configFile."rofi/config.rasi".source = ./config.rasi;
  };
}
