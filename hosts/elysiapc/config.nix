{ hostname , ... }:

{
  imports = [
    ../../os/configuration.nix
    ./hardware-configuration.nix
    ./software.nix
    ./graphics-driver.nix
  ];

  networking.hostName = "${hostname}";
}
