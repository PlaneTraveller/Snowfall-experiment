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
  programs.fish.enable = true;

  home.packages = with pkgs; [
    btop
    fzf
    unison

  ];

  # home.sessionPath = [ "$HOME/bin" ];

  home.stateVersion = "23.11";
}
