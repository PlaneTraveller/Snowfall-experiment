{ lib, pkgs, config, osConfig ? { }, format ? "unknown", ... }:

with lib.literacy; {
  literacy = {
    user = {
      enable = true;
      name = "wanghy"
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
