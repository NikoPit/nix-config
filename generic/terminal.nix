{ pkgs, settings, ... }:

let
  ghostty = "${pkgs.ghostty}/bin/ghostty";
in
{
  keybinds = [
    {
      combo = { mods = [ "SUPER" ]; key = "Q"; };
      action.exec = ghostty;
    }
  ];

  programs.ghostty = {
    enable = true;

    settings = {
      cursor-color = settings.palette.blue1;
      cursor-opacity = 0.5;

      window-padding-x = 10;
      window-padding-y = 5;
    };
  };
}
