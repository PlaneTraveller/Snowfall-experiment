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
      };
    };

  };
}
