{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.desktop.plasma6;
in {
  options.literacy.desktop.plasma6 = with types; {
    enable = mkBoolOpt false "Enable or disable plasma6";
  };

  config = mkIf cfg.enable {
    # services.displayManager.sddm.enable = true;
    # services.displayManager.sddm.wayland.enable = true;
    services.xserver.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.xserver.displayManager.sddm.wayland.enable = true;

    literacy.user.extraOptions.packages = with pkgs; [ libsForQt5.polonium ];
  };
}
