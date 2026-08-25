{ pkgs, ... }:

let
  rofi = "${pkgs.rofi}/bin/rofi";
in
{
  keybinds = [
    {
      combo = { mods = [ "SUPER" ]; key = "SPACE"; };
      action.exec = "${rofi} -show drun";
    }
  ];

  programs.rofi = {
    enable = true;
  };
}
