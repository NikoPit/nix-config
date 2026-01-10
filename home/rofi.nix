{ pkgs , ... }:

{
  programs.rofi = {
    enable = true;

    package = pkgs.rofi-wayland;

    theme = ./rofi-theme.rasi;
  };
}
