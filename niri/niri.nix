{ pkgs, ... }:

{
  imports = [
    ./binds.nix
    ./outputs.nix
    ./misc.nix
    ./layer-rules.nix
    ./spawn-at-startup.nix
  ];
}
