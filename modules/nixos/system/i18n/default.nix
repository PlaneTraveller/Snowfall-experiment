{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.system.i18n;
in {
  options.literacy.system.i18n = with types; {
    enable = mkBoolOpt false "Whether or not to configure i18n.";
  };

  config = mkIf cfg.enable {
    i18n.inputMethod = {
      type.enable = "fcitx5";
      fcitx5.addons = with pkgs;
        [
          # fcitx5-mozc
          # fcitx5-gtk
          # fcitx5-rime
          fcitx5-chinese-addons
        ];
      # enabled = "ibus";
      # ibus.engines = with pkgs.ibus-engines; [
      #   libpinyin
      #   rime
      # ];
    };
  };
}
