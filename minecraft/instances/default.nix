{ pkgs, ... }:

{
  nixcraft.client.instances = {
    "LiquidBounce" = import ./liquidbounce.nix { inherit pkgs; };
    "Skyblock" = import ./skyblock.nix { inherit pkgs; };
    "Wynncraft" = import ./wynncraft.nix { inherit pkgs; };
  };
}
