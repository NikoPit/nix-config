let
  exec = "ghostty";
  bind = "SUPER, Q, exec, ${exec}";
in
{
  programs.ghostty = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.bind = [ bind ];
}
