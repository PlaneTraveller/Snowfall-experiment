{ lib, pkgs, config, osConfig ? { }, format ? "unknown", ... }:

with lib.literacy; {
  literacy = {
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
      direnv = enabled;
      # nushell = enabled;
    };

    apps = {
      # activitywatch = enabled;
      emacs = enabled;
    };
  };

  # networking = { proxy = { clash-verge = enabled; }; };
  programs.fish.enable = true;
  # home.sessionPath = [ "$HOME/bin" ];

  home.stateVersion = "23.11";
}
