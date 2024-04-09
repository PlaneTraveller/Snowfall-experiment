{ options, config, pkgs, lib, inputs, ... }:
with lib;
with lib.literacy;
let cfg = config.home;
in {
  options.home = with types; {
    enable = mkBoolOpt true "Enable Home on NixOS";
    file = mkOpt attrs { }
      (mdDoc "A set of files to be managed by home-manager's `home.file`.");
    configFile = mkOpt attrs { } (mdDoc
      "A set of files to be managed by home-manager's `xdg.configFile`.");
    extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
  };

  config = mkIf cfg.enable {
    # programs.home-manager = enabled;

    home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.home.configFile;
    };

    snowfallorg.user.${config.user.name}.home.config = config.home.extraOptions;

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
