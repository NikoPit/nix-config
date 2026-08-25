{ pkgs, config, ... }:

let
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";

  screenshotPath = "${config.home.homeDirectory}/Pictures/latest_screenshot.png";

  command = "${grim} -g \"$(${slurp})\" - | tee ${screenshotPath} | ${wl-copy}";

  wrapper = pkgs.writeShellScriptBin "screenshot" command;
in
{
  keybinds = [
    {
      combo = { mods = [ ]; key = "PRINT"; };
      action.exec = "${wrapper}/bin/screenshot";
    }
  ];
}
