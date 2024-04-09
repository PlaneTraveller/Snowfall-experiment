{ options, config, pkgs, lib, ... }:

with lib;
with lib.literacy;
let cfg = config.literacy.hardware.bluetooth;
in {

  #=============================================================
  #== Options
  options.literacy.hardware.bluetooth = with types; {
    enable = mkBoolOpt true "Whether or not to enable bluetooth";
  };

  #=============================================================
  #== Config
  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
