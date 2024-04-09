{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let
  cfg = config.literacy.cli.git;
  user = config.literacy.user;
in {
  options.literacy.cli.git = with types; {
    enable = mkBoolOpt false "Enable or disable git";
    userName = mkOpt types.str user.fullName "The name to configure git with.";
    userEmail = mkOpt types.str user.email "The email to configure git with.";
    signingKey = mkOpt types.str "" "The key ID to sign commits with.";
    signByDefault =
      mkOpt types.bool false "Whether to sign commits by default.";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      inherit (cfg) userName userEmail;
      # lfs = enabled;
      # signing = {
      #   key = cfg.signingKey;
      #   inherit (cfg) signByDefault;
      # };
      extraConfig = {
        init = { defaultBranch = "dev"; };
        # pull = { rebase = true; };
        # push = { autoSetupRemote = true; };
        # core = { whitespace = "trailing-space,space-before-tab"; };
        # safe = {
        #   directory = "${user.home}/work/config";
        # };
      };
    };

    # environment.systemPackages = with pkgs; [
    #   git
    #   git-remote-gcrypt

    #   gh # GitHub cli

    #   # lazygit
    #   # commitizen
    # ];

    # environment.shellAliases = {
    #   # Git aliases
    #   ga = "git add .";
    #   gc = "git commit -m ";
    #   gp = "git push -u origin";

    #   # g = "lazygit";
    # };

    # home.configFile."git/config".text = import ./config.nix {
    #   sshKeyPath = "/home/${config.user.name}/.ssh/key.pub";
    # };
    # home.configFile."lazygit/config.yml".source = ./lazygitConfig.yml;

    # home.persist.directories = [
    #   ".config/gh"
    #   # ".config/lazygit"
    #   ".config/systemd" # For git maintainance
    # ];
  };
}
