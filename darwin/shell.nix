{ settings, pkgs, ... }:

{
  programs.fish.enable = true;

  environment.shells = [ pkgs.fish ];

  users.users.${settings.user.name}.shell = pkgs.fish;
}
