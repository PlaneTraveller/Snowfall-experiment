{ options, config, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.hardware.nvidia;
in {
  options.literacy.hardware.nvidia = with types; {
    enable = mkBoolOpt false "Enable drivers and patches for Nvidia hardware.";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    hardware.nvidia.open = false;

    environment.variables = { CUDA_CACHE_PATH = "$XDG_CACHE_HOME/nv"; };
    environment.shellAliases = {
      nvidia-settings =
        "nvidia-settings --config='$XDG_CONFIG_HOME'/nvidia/settings";
    };

    # Hyprland settings
    # programs.hyprland.enableNvidiaPatches = true;
    # environment.sessionVariables.WLR_NO_HARDWARE_CURSORS =
    #   "1"; # Fix cursor rendering issue on wlr nvidia.
  };
}
