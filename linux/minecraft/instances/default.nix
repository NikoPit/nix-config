{ pkgs, config, ... }:

{
  nixcraft.client.instances = {
    skyblock = import ./skyblock.nix { inherit pkgs config; };
    wynncraft = import ./wynncraft.nix { inherit pkgs; };
  };
}
