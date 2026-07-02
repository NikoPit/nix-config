{ hostname, ... }:

{
  imports = [
    ../../os/configuration.nix
    ./hardware-configuration.nix
    ./software.nix
    ./graphics-driver.nix
  ];

  networking.hostName = "${hostname}";
  _module.args.diskDevice = "/dev/disk/by-id/nvme-Fanxiang_S790C_1TB_FXS790C250241059";
}
