{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.home;
in {
  options.literacy.home = with types; {
    enable = mkBoolOpt true "Enable Home on NixOS";
    file = mkOpt attrs { }
      (mdDoc "A set of files to be managed by home-manager's `home.file`.");
    configFile = mkOpt attrs { } (mdDoc
      "A set of files to be managed by home-manager's `xdg.configFile`.");
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = mkIf cfg.enable {
    # programs.home-manager = enabled;

    literacy.home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.literacy.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.literacy.home.configFile;
    };

    snowfallorg.users.${config.literacy.user.name}.home.config =
      config.literacy.home.extraOptions;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
