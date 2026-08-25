{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  _module.args.greeterSession = "${pkgs.hyprland}/bin/start-hyprland";
}
