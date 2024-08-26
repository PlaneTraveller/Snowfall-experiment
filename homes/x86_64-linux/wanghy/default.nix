{ lib, pkgs, config, osConfig ? { }, format ? "unknown", ... }:

with lib.literacy; {
  literacy = {
    user = {
      enable = false;
      # name = config.snowfallorg.user.name;
    };

    cli = {
      home-manager = enabled;
      git = enabled;
      direnv = enabled;
    };

    apps = { };
  };

  # home.sessionPath = [ "$HOME/bin" ];

  home.stateVersion = "23.11";
}
