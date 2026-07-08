{ pkgs, ... }:

let
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";

  command = "${grim} -g \"$(${slurp})\" - | ${wl-copy}";

  wrapper = pkgs.writeShellScriptBin "screenshot" command;
  exec = "${wrapper}/bin/screenshot";

  bind = ", Print, exec, ${exec}";
in
{
  wayland.windowManager.hyprland.settings.bind = [ bind ];
}
