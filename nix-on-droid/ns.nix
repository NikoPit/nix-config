{ config, deviceName, ... }:
{
  programs.fish.shellAliases.ns =
    "nix-on-droid switch --flake ${config.home.homeDirectory}/nix#${deviceName}";
}
