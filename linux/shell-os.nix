{ pkgs, settings, ... }:

{
  users.users.${settings.user.name}.shell = pkgs.fish;

  programs = {
    fish.enable = true;
  };
}
