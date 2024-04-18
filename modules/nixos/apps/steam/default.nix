{ options, config, lib, pkgs, ... }:

with lib;
with lib.literacy;
let cfg = config.literacy.apps.steam;
in {
  options.literacy.apps.steam = with types; {
    enable = mkBoolOpt false "Whether or not to enable support for Steam.";
  };

  config = mkIf cfg.enable {
    # programs.steam.enable = true;
    # programs.steam.remotePlay.openFirewall = true;
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    hardware.steam-hardware.enable = true;

    # Enable GameCube controller support.
    services.udev.packages = [ pkgs.dolphinEmu ];

    # environment.systemPackages = with pkgs.plusultra; [
    #   steam
    # ];

    # environment.sessionVariables = {
    #   STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$HOME/.steam/root/compatibilitytools.d";
    # };
  };
}
