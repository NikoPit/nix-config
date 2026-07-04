{ pkgs, ... }:
{
  proxy = import ./proxy.nix;
  style = import ./style.nix { inherit pkgs; };
  misc = import ./misc.nix;
  user = import ./user.nix;
}
