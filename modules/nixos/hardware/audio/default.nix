{ options, config, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.hardware.audio;
in {
  options.literacy.hardware.audio = with types; {
    enable = mkBoolOpt false "Enable pipewire";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    programs.noisetorch.enable = true;
  };
}
