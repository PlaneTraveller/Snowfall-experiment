{ options, config, lib, pkgs, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.cli.nushell;
in {
  options.literacy.cli.nushell = with types; {
    enable = mkBoolOpt false "Enable nushell as a shell";
  };

  config = {
    # environment.systemPackages = with pkgs; [ eza bat nitch zoxide starship ];

    # users.defaultUserShell = pkgs.${cfg.shell};
    # users.users.root.shell = pkgs.bashInteractive;

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    literacy.home.configFile."starship.toml".source = ./starship.toml;

    # environment.shellAliases = {
    #   ".." = "cd ..";
    #   neofetch = "nitch";
    # };

    programs.zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };

    programs.nushell = {
      enable = true;
      # shellAliases = config.environment.shellAliases // { ls = "ls"; };
      envFile.text = "";
      extraConfig = ''
        $env.config = {
        	show_banner: false,
        }

        def , [...packages] {
            nix shell ...($packages | each {|s| $"nixpkgs#($s)"})
        }
      '';
    };
  };
}
