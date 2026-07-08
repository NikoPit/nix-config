{ hostname, ... }:

{
  imports = [
    ./greeter.nix

    ./fish.nix
    ./style.nix
    ./steam.nix
  ];
}
