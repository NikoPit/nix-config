{ pkgs, ... }:

{
  nixcraft.client.instances = {
    liquidBounce = import ./liquidbounce.nix { inherit pkgs; };
    skyblock = import ./skyblock.nix { inherit pkgs; };
    wynncraft = import ./wynncraft.nix { inherit pkgs; };
  };
}
