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
        sarasa-gothic
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        noto-fonts-lgc-plus
        texlivePackages.ctex
        texlivePackages.noto
        liberation_ttf

        source-code-pro
        hack-font

        nerdfonts
        jetbrains-mono
        ibm-plex
        overpass
        julia-mono
        merriweather
        alegreya
        twitter-color-emoji

        fira-code
        fira-code-symbols
        emacs-all-the-icons-fonts
        # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ] ++ cfg.fonts;
  };
}
