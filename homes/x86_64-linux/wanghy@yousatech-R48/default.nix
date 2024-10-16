{ lib, pkgs, config, osConfig ? { }, format ? "unknown", ... }:

let
  githubToken = builtins.readFile "/home/wanghy/Snowfall-experiment/homes/x86_64-linux/wanghy@yousatech-R48/github.token";
in

with lib.literacy; {
  literacy = {
    user = {
      enable = true;
      name = "wanghy";

    };

    cli = {
      home-manager = enabled;
      # git = enabled;
      direnv = enabled;
    };

    apps = { };
  };
  programs.ssh.enable = true;
  services.ssh-agent.enable = true;

  programs.fish = {
    enable = true;
    shellInit = ''
      set -Ux OPENBLAS_NUM_THREADS 32
    '';
  };

  nix.settings = {
    access-tokens = githubToken;
  };

  home.packages = with pkgs; [
    btop
    fzf
    unison
    python311Packages.python-lsp-server
    tmux
    pv
    progress
    lynx
    ncdu
  ];

  # home.sessionPath = [ "$HOME/bin" ];


  home.stateVersion = "23.11";
}
