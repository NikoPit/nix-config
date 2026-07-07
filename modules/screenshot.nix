{ pkgs, ... }:

let
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
  command = "${grim} -g \"$(${slurp})\" - | ${wl-copy}";
in
{
  _module.args.screenshot = command;
}
