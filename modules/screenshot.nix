{ pkgs, settings, ... }:

let
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";

  screenshotPath = "/home/${settings.user.name}/Pictures/latest_screenshot.png";

  command = "${grim} -g \"$(${slurp})\" - | tee ${screenshotPath} | ${wl-copy}";

  wrapper = pkgs.writeShellScriptBin "screenshot" command;
  exec = "${wrapper}/bin/screenshot";

  bind = ", Print, exec, ${exec}";
in
{
  wayland.windowManager.hyprland.settings.bind = [ bind ];
}
