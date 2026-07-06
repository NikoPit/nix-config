{ hostname, ... }:

{
  imports = [
    ./greetd.nix
    ./fish.nix
    ./stylix.nix
    ./steam.nix

    ../hyprland/os.nix
    ../nixvim

    ../hosts/${hostname}
    ../system
  ];
}
