{ options, config, pkgs, lib, ... }:
with lib;
with lib.literacy;
let cfg = config.literacy.cli.proxychains;
in {
  options.literacy.cli.proxychains = with types; {
    enable = mkBoolOpt false "Whether or not to configure proxychains.";
  };

  config = mkIf cfg.enable {
    programs.proxychains = {
      enable = true;
      proxies = {
        myproxy = {
          enable = true;
          type = "socks5";
          host = "127.0.0.1";
          port = 21073;
        };
      };
    };
  };
}
