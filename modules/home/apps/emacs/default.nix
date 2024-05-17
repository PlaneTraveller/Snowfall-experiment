{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let
  cfg = config.literacy.apps.emacs;
  user = config.literacy.user;
  envExtra = ''
    export PATH="${config.xdg.configHome}/emacs/bin:$PATH"
  '';
  shellAliases = {
    e = "emacsclient --create-frame"; # gui
    et = "emacsclient --create-frame --tty"; # termimal
  };
in {
  options.literacy.apps.emacs = with types; {
    enable = mkBoolOpt false "Enable or disable emacs";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      package = pkgs.emacs29-pgtk;
      extraPackages = epkgs: [ epkgs.vterm ];
    };

    services.emacs = {
      enable = true;
      defaultEditor = true;
      # package = with pkgs;
      #   ((emacsPackagesFor emacs29-pgtk).emacsWithPackages
      #     (epkgs: [ epkgs.vterm ]));

      client = {
        enable = true;
        arguments = [ " --create-frame" ];
      };
      # startWithUserSession = true;
    };

    home.packages = with pkgs; [
      black
      python312Packages.pyflakes
      isort
      pipenv
      ripgrep
      fd

      git
      gnutls
      imagemagick
      zstd

    ];

    home.sessionPath = [ "$HOME/.config/emacs/bin" ];
  };
}
