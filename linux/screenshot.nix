{ pkgs, lib, ... }:

let
  hyprshot = lib.getExe pkgs.hyprshot;
  command = "${hyprshot} -m region --freeze";
in
{
  keybinds = [
    {
      combo = {
        mods = [ ];
        key = "PRINT";
      };
      action.exec = command;
    }
  ];
}
