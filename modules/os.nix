{ hostname, ... }:

{
  imports = [
    ./greeter.nix

    ./fish.nix
    ./stylix.nix
    ./steam.nix
  ];
}
