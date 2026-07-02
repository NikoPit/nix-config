{ hostname, ... }:

{
  imports = [
    ../../os/configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "${hostname}";
  _module.args.diskDevice = "TODO";
}
