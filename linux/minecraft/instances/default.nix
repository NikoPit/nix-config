{ pkgs, config, ... }:

{
  nixcraft.client.instances = {
    liquidBounce = import ./liquidbounce.nix { inherit pkgs; };
    skyblock = import ./skyblock.nix { inherit pkgs config; };
    wynncraft = import ./wynncraft.nix { inherit pkgs; };
  };
}
