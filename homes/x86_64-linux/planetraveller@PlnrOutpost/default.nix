{ lib, pkgs, config, osConfig ? { }, format ? "unknown", ... }:

with lib.literacy; {
  literacy = {
    user = {
      enable = true;
      # name = config.snowfallorg.user.name;
    };

    cli = {
      home-manager = enabled;
      git = enabled;
      direnv = enabled;
      nushell = enabled;
    };

    apps = {
      # activitywatch = enabled;
      emacs = enabled;
    };
  };

  # home.sessionPath = [ "$HOME/bin" ];

  home.stateVersion = "23.11";
}
