{ lib, osConfig ? { }, ... }: {
  home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "23.11");
}

# { options, config, pkgs, lib, inputs, ... }:
# with lib;
# with lib.literacy;
# let cfg = config.home;

# in {
#   options.home = with types; {
#     # file = mkOpt attrs { }
#     #   (mdDoc "A set of files to be managed by home-manager's `home.file`.");
#     configFile = mkOpt attrs { } (mdDoc
#       "A set of files to be managed by home-manager's `xdg.configFile`.");
#     extraOptions = mkOpt attrs { } "Options to pass directly to home-manager.";
#   };

#   config = {
#     home.extraOptions = {
#       home.stateVersion = config.system.stateVersion;
#       # home.file = mkAliasDefinitions options.home.file;
#       xdg.enable = true;
#       xdg.configFile = mkAliasDefinitions options.home.configFile;
#     };

#     # snowfallorg.user.${config.user.name}.home.config = config.home.extraOptions;

#     # home-manager = {
#     #   useUserPackages = true;
#     #   useGlobalPkgs = true;
#     # };
#   };
# }
