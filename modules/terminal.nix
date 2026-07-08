{ pkgs, ... }:

let
  ghostty = "${pkgs.ghostty}/bin/ghostty";
  bind = "SUPER, Q, exec, ${ghostty}";
in
{
  programs.ghostty = {
    enable = true;
  };

  wayland.windowManager.hyprland.settings.bind = [ bind ];
}
