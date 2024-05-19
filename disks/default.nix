{ device ? throw "Set this to your disk device, e.g. /dev/sda", ... }: {
  disko.devices = {
    disk.main = {
      inherit device;
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "lvm_pv";
              vg = "pool";
            };
          };
        };
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          # The main root partition
          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];

              subvolumes = {
                "/_rootvol" = { mountpoint = "/"; };

                # "/persist" = {
                #   mountOptions = [ "subvol=persist" "noatime" ];
                #   mountpoint = "/persist";
                # };

                "/_nixvol" = {
                  mountOptions = [ "subvol=_nixvol" "noatime" "compress=zstd" ];
                  mountpoint = "/nix";
                };

                "/_snapvol" = {
                  mountOptions =
                    [ "subvol=_snapvol" "noatime" "compress=zstd" ];
                  mountpoint = "/snapshots";
                };

                "/_homevol" = {
                  mountOptions = [ "subvol=home" "noatime" "compress=zstd" ];
                  mountpoint = "/home";
                };

                "/" = {
                  mountOptions = [ "subvol=/" ];
                  mountpoint = "/mnt/defvol";
                };
              };
            };
          };
        };
      };
    };
  };
}
