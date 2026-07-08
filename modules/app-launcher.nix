let
  exec = "rofi -show drun";
  bind = "SUPER, SPACE, exec, ${exec}";
in
{
  programs.rofi = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.bind = [ bind ];
}
