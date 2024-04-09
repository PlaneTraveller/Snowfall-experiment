{ lib, config, pkgs, osConfig ? { }, ... }:
let
  inherit (lib) types mkIf mkDefault mkMerge;
  inherit (lib.literacy) mkOpt;

  cfg = config.user;

  is-linux = pkgs.stdenv.isLinux;
  is-darwin = pkgs.stdenv.isDarwin;

  home-directory = if cfg.name == null then
    null
  else if is-darwin then
    "/Users/${cfg.name}"
  else
    "/home/${cfg.name}";
in {
  options.user = {
    enable = mkOpt types.bool true "Whether to configure the user account.";
    name =
      mkOpt (types.nullOr types.str) ("planetraveller") "The user account.";

    fullName = mkOpt types.str "Huayu Wang" "The full name of the user.";
    email = mkOpt types.str "why123jj@126.com" "The email of the user.";

    home = mkOpt (types.nullOr types.str) home-directory
      "The user's home directory.";
  };

  config = mkIf cfg.enable (mkMerge [{
    assertions = [
      {
        assertion = cfg.name != null;
        message = "user.name must be set";
      }
      {
        assertion = cfg.home != null;
        message = "user.home must be set";
      }
    ];

    home = {
      username = mkDefault cfg.name;
      homeDirectory = mkDefault cfg.home;
    };
  }]);
}
