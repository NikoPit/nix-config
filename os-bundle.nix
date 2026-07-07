{ hostname, ... }:

{
  imports = [
    ./hyprland/os.nix
    ./nixvim

    ./hosts/${hostname}
    ./system

    ./modules/os.nix
  ];
}
