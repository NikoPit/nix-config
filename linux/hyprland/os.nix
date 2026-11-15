{ lib, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  _module.args.greeterSession = lib.getExe' pkgs.hyprland "start-hyprland";
}
