{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ./configuration.nix ];
  networking.hostName = "PlanarSphere";

  # Enable Bootloader
  # system.boot.efi.enable = true;
  # system.boot.bios.enable = true;

  # system.battery.enable = true; # Only for laptops, they will still work without it, just improves battery life

  # suites.common.enable = true; # Enables the basics, like audio, networking, ssh, etc.
  # test.old.enable = true

  # suites.desktop.enable = true;
  # suites.gaming.enable = true;

  hardware.nvidia.enable = true;
  networking.proxy.clash-verge.enable = true;

  environment.systemPackages = with pkgs;
    [
      # Any particular packages only for this host
    ];

  # ======================== DO NOT CHANGE THIS ========================
  system.stateVersion = "23.11";
  # ======================== DO NOT CHANGE THIS ========================
}
