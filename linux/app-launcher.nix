{ pkgs, lib, ... }:

let
  rofi = lib.getExe pkgs.rofi;
in
{
  keybinds = [
    {
      combo = {
        mods = [ "SUPER" ];
        key = "SPACE";
      };
      action.exec = "${rofi} -show drun";
    }
  ];

  programs.rofi = {
    enable = true;
  };
}
