{ pkgs, lib, ... }:

{
  user.shell = lib.getExe pkgs.fish;
}
