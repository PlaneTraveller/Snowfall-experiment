{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.system.fonts;
in {
  options.literacy.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [ font-manager ];

    fonts.packages = with pkgs;
      [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji

        source-code-pro
        hack-font
        jetbrains-mono
        ibm-plex
        overpass
        emacs-all-the-icons-fonts
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ] ++ cfg.fonts;
  };
}
