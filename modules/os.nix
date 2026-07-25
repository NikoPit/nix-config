{ hostname, ... }:

{
  imports = [
    ./greeter.nix

    ./shell-os.nix
    ./style.nix
    ./steam.nix
    ./runescape.nix
  ];
}
