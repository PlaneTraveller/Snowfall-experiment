{ lib, pkgs, config, osConfig ? { }, format ? "unknown", ... }:

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
    access-tokens = "github.com=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";
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
