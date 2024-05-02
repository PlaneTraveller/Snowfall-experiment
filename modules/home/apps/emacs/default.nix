{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let
  cfg = config.literacy.apps.emacs;
  user = config.literacy.user;
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

    };
    home.sessionPath = [ "$HOME/.config/emacs/bin" ];
  };
}
