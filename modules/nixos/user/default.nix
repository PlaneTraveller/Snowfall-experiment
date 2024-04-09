{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.user;
in {
  options.literacy.user = with types; {
    name = mkOpt str "planetraveller" "The name to use for the user account.";
    fullName = mkOpt str "Huayu Wang" "The full name of the user.";
    email = mkOpt str "why123jj@126.com" "The email of the user.";
    initialPassword = mkOpt str "password"
      "The initial password to use when the user is first created.";
    # icon =
    #   mkOpt (nullOr package) defaultIcon
    #   "The profile picture to use for the user.";
    # prompt-init = mkBoolOpt true "Whether or not to show an initial message when opening a new shell.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions =
      mkOpt attrs { } (mdDoc "Extra options passed to `users.users.<name>`.");
  };

  config = {
    users.users.${cfg.name} = {
      isNormalUser = true;
      home = "/home/${cfg.name}";
      group = "users";
      shell = pkgs.fish;
      extraGroups = [ ] ++ cfg.extraGroups;
    } // cfg.extraOptions;

    environment.systemPackages = with pkgs;
      [
        # propagatedIcon
      ];

    programs.fish = { enable = true; };
  };
}
