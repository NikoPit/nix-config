{ pkgs, ... }:

let 
  nix-update = import ./nix-update.nix { inherit pkgs; };
in {
  # System scripts
  environment.systemPackages = [
    nix-update
  ];

}
