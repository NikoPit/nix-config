{
  pkgs,
  settings,
  ...
}:

let
  ghostty = "${pkgs.ghostty}/bin/ghostty";
  bind = "SUPER, Q, exec, ${ghostty}";
in
{
  programs.ghostty = {
    enable = true;

    settings = {
      cursor-color = settings.palette.blue1;
      cursor-opacity = 0.5;
    };
  };

  wayland.windowManager.hyprland.settings.bind = [ bind ];
}
