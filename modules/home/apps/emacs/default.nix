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
  myEmacsPackageFor = emacs:
    ((pkgs.emacsPackagesFor emacs).emacsWithPackages (epkgs: [ epkgs.vterm ]));
  emacsPkg = myEmacsPackageFor pkgs.emacs29-pgtk;
in {
  options.literacy.apps.emacs = with types; {
    enable = mkBoolOpt false "Enable or disable emacs";
  };

  config = mkIf cfg.enable {
    # programs.emacs = {
    #   enable = true;
    #   package = pkgs.emacs29-pgtk;
    #   extraPackages = epkgs: [ epkgs.vterm ];
    # };

    # Modified pkgs with Ryan's config
    services.emacs = {
      enable = true;
      defaultEditor = true;
      package = emacsPkg;
      client = {
        enable = true;
        arguments = [ " --create-frame" ];
      };
      startWithUserSession = true;
    };

    home.packages = with pkgs;
      [
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
        sqlite
        ispell

      ] ++ [ emacsPkg ];

    programs = {
      bash.bashrcExtra = envExtra;
      zsh.envExtra = envExtra;
      fish = {
        interactiveShellInit = envExtra;
        shellAliases = shellAliases;
      };

      nushell.shellAliases = shellAliases;

    };
    home.shellAliases = shellAliases;

  };
}
