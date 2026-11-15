{ config, settings, ... }:

{
  programs.fish.enable = true;

  environment.shells = [ config.programs.fish.package ];

  users.users.${settings.user.name}.shell = config.programs.fish.package;
}
