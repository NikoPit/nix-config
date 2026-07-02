{ diskDevice, ... }:

let
  makeMountOptions = { }: [
    "compress=zstd"
    "noatime"
  ];
  defaultMountOptions = makeMountOptions { };
in
{
  disko.devices.disk.main = {
    device = diskDevice;
    type = "disk";

    content = {
      type = "gpt";

      partitions = {
        esp = {
          type = "EF00";
          size = "1G";

          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
          };
        };

        root = {
          size = "100%";

          content = {
            type = "btrfs";

            subvolumes = {
              root = {
                mountpoint = "/";
                mountOptions = defaultMountOptions;
              };

              home = {
                mountpoint = "/home";
                mountOptions = defaultMountOptions;
              };

              nix = {
                mountpoint = "/nix";
                mountOptions = defaultMountOptions;
              };

              log = {
                mountpoint = "/var/log";
                mountOptions = defaultMountOptions;
              };

              swap = {
                mountpoint = "/.swap";
                swap.swapfile.size = "16G";
              };
            };
          };
        };
      };
    };
  };
}
