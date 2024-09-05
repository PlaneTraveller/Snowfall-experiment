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
      # nushell = enabled;
    };

    apps = {
      # activitywatch = enabled;
      emacs = enabled;
    };
  };

  # home.sessionPath = [ "$HOME/bin" ];

  #== Temporary config
  programs.fish.enable = true;
  services.unison = {
    enable = true;
    pairs = {
      #== Zhao Lab
      # test command: (extracted from service file)
      # unison -sshargs = "-p 22" -root =
      "zhaolab1-projdir" = {
        commandOptions = {
          auto = "true";
          # sshargs = "-p 22";
          servercmd = "/home/wanghy/.nix-profile/bin/unison";
        };
        roots = [
          "/home/planetraveller/Desktop/Research/ZhaoLab/projects/bert-virus-finder"
          "ssh://wanghy@10.19.29.122//home/wanghy/bert-virus-finder"
        ];
      };

    };

  };

  home.packages = with pkgs;
    [
      unison

    ];

  home.stateVersion = "23.11";
}
