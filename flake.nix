{
  description = "One Flake to rule them all.";

  #=============================================================
  #== Settings
  # nixConfig = {
  #   trusted-users = [ "planetraveller" ];
  #   substituters = [
  #     # cache mirror located in China
  #     # status: https://mirror.sjtu.edu.cn/
  #     "https://mirror.sjtu.edu.cn/nix-channels/store"
  #     # status: https://mirrors.ustc.edu.cn/status/
  #     # "https://mirrors.ustc.edu.cn/nix-channels/store"
  #     "https://cache.nixos.org"
  #     "https://nix-community.cachix.org"
  #   ];
  #   trusted-public-keys = [
  #     "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  #     "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #   ];
  # };

  #=============================================================
  #== Inputs
  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    # home-manager = {
    #       url = "github:nix-community/home-manager/release-23.11";
    #       inputs.nixpkgs.follows = "nixpkgs";
    # };

    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager/master";
    # home-manager.url =
    #   "github:nix-community/home-manager/archive/release-23.11.tar.gz";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

  };

  #=============================================================
  #== Outputs
  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;
        snowfall = {
          meta = {
            name = "literacy";
            title = "Literacy";
          };
          namespace = "literacy";
        };
      };

    in lib.mkFlake {
      inherit inputs;
      src = ./.;

      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [ ];
      };

      #== Overlays
      overlays = with inputs; [ ];

      #== Systems config
      systems = {
        # Global modules
        modules = {
          darwin = with inputs; [ ];
          nixos = with inputs; [ home-manager.nixosModules.home-manager ];
        };

        hosts = {
          PlanarSphere.modules = with inputs;
            [
              # ./configuration.nix
              # ./hardware-configuration.nix
              # (import ./disks/default.nix {
              #   inherit lib;
              #   device = "/dev/sda";
              # })
            ];
          PlnrOutpost.modules = with inputs;
            [
              (import ./disks/default.nix {
                inherit lib;
                device = "/dev/nvme0n1";
              })
            ];
        };
      };

      #== Homes config
      # homes = {
      #   modules = with inputs;
      #     [

      #     ];
      #   users = { };
      # };

      #== Unknown
      # templates = import ./templates { };
    };
}
