{ config, settings, ... }:

{
  users.users.${settings.user.name}.shell = config.programs.fish.package;

  programs = {
    fish.enable = true;
  };
}
