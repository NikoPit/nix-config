{ hostname, ... }:

{
  imports = [
    ./greeter.nix

    ./fish-os.nix
    ./style.nix
    ./steam.nix
  ];
}
