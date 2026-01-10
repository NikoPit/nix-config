{ pkgs , ... }:

{
  programs.rofi = {
    enable = true;

    package = pkgs.rofi-wayland;
  };

  imports = [ ./rofi-theme.nix ];
}
