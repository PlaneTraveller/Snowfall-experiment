{ options, config, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.cli.direnv;
in {
  options.literacy.cli.direnv = with types; {
    enable = mkBoolOpt false "Enable direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableNushellIntegration = true;
    };

    # environment.sessionVariables.DIRENV_LOG_FORMAT =
    #   ""; # Blank so direnv will shut up

    # home.persist.directories = [ ".local/share/direnv" ];
  };
}
