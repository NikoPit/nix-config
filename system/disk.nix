let
  makeMountOptions = { }: [
    "compress=zstd"
    "noatime"
  ];
  defaultMountOptions = makeMountOptions { };
  makeSubvolume = mountpoint: {
    mountpoint = mountpoint;
    mountOptions = defaultMountOptions;
  };
in
{
  disko.devices.disk.main = {
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
              root = makeSubvolume "/";
              home = makeSubvolume "/home";
              nix = makeSubvolume "/nix";
              log = makeSubvolume "/var/log";

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
