{ hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./graphics-driver.nix
  ];

  networking.hostName = "${hostname}";
}
