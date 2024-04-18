{ options, config, pkgs, lib, ... }:

with lib;
with lib.literacy;
let cfg = config.literacy.services.syncthing;
in {
  options.literacy.services.syncthing = with types; {
    enable = mkBoolOpt false "Whether or not to configure syncthing.";
    devices = mkOpt attrs { } "Devices to connect to.";

  };

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      user = "planetraveller";
      dataDir = "/home/planetraveller";
      configDir = "/home/planetraveller/.config/syncthing";
      openDefaultPorts = true;
      overrideDevices =
        true; # overrides any devices added or deleted through the WebUI
      overrideFolders =
        true; # overrides any folders added or deleted through the WebUI
      guiAddress = "127.0.0.1:8384";
      settings = {
        devices = {
          "PlanarOutpost" = {
            id =
              "DKU7AVM-OGT2QDY-LUJF6PQ-UJ25FJW-MWEPKNQ-BXMKOJR-7EYDGD5-6RCE3QV";
          };
        };
        folders = {
          "Desktop" = {
            path = "~/Desktop";
            devices = [ "PlanarOutpost" ];
            ignorePerms = true;
            versioning = {
              type = "staggered";
              params = {
                cleanInterval = "3600";
                maxAge = "5260000";
              };
            };
          };
          "Archive" = {
            path = "~/Archive";
            devices = [ "PlanarOutpost" ];
            ignorePerms = true;
            versioning = {
              type = "simple";
              params = { keep = "10"; };
            };
          };
          "Literacy" = {
            enabled = false;
            path = "~/Literacy";
            devices = [ "PlanarOutpost" ];
            ignorePerms = true;
            versioning = {
              type = "staggered";
              params = {
                cleanInterval = "3600";
                maxAge = "15552000";
              };
            };
          };
          "Aesthetics" = {
            path = "~/Aesthetics";
            devices = [ "PlanarOutpost" ];
            ignorePerms = true;
            versioning = {
              type = "simple";
              params = { keep = "10"; };
            };
          };
        };
      };
    };
  };
}
