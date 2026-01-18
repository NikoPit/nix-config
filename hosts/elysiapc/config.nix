{ hostname , ... }:

{
  imports = [
    ../../os/configuration.nix
    ./hardware-configuration.nix
    ./software.nix
    ./graphics-driver.nix
    ./star-citizen.nix
  ];

  networking.hostName = "${hostname}";
}
