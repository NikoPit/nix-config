{ hostname, ... }:

{
  imports = [
    ../../os
    ./hardware-configuration.nix
  ];

  networking.hostName = "${hostname}";
  _module.args.diskDevice = "TODO";
}
