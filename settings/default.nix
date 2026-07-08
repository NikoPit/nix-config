{ pkgs, ... }:
rec {
  proxy = import ./proxy.nix;
  misc = import ./misc.nix;
  user = import ./user.nix;
  localization = import ./localization.nix;

  # Path to the nix system configuration
  configPath = /home/${user.name}/nix;
}
