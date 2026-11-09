{ pkgs, ... }:

let
  hyprshot = "${pkgs.hyprshot}/bin/hyprshot";
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
