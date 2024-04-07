{ lib, pkgs, config, osConfig ? { }, format ? "unknown", ... }:

with lib.literacy; {
  user = {
    enable = true;
    # name = config.snowfallorg.user.name;
  };

  cli = {
    # zsh = enabled;
    # tmux = enabled;
    # neovim = enabled;
    home-manager = enabled;
    git = enabled;
  };

  # networking = { proxy = { clash-verge = enabled; }; };

  # home.sessionPath = [ "$HOME/bin" ];

  home.stateVersion = "23.11";
}
