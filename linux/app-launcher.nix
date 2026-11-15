{ config, lib, ... }:

let
  rofi = lib.getExe config.programs.rofi.package;
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
