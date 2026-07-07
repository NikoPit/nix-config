{ pkgs, ... }:

let
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";

  command = "${grim} -g \"$(${slurp})\" - | ${wl-copy}";

  wrapper = pkgs.writeShellScriptBin "screenshot" command;
in
{
  _module.args.screenshot = "${wrapper}/bin/screenshot";
}
