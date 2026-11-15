{ config, lib, ... }:

{
  user.shell = lib.getExe config.home-manager.config.programs.fish.package;
}
