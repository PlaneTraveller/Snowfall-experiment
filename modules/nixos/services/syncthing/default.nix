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
          "PlanarSphere" = {
            id =
              "SITLQYT-C33QV2W-5HDTXUG-ZCCTXP3-AH25B3M-AFHRJE7-3U7AM2M-UMKRKAC";
          };
          "PlnrOutpost" = {
            id =
              "FKE4LPF-F4AKBHD-W5LCPBM-PCGGHDA-OO752RT-XRV7QBA-6TPELIQ-KML5DQQ";
          };
        };
        folders = {
          "Desktop" = {
            path = "~/Desktop";
            devices = [ "PlnrOutpost" ];
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
            devices = [ "PlnrOutpost" ];
            ignorePerms = true;
            versioning = {
              type = "simple";
              params = { keep = "10"; };
            };
          };
          "Literacy" = {
            enabled = false;
            path = "~/Literacy";
            devices = [ "PlnrOutpost" ];
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
            devices = [ "PlnrOutpost" ];
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
