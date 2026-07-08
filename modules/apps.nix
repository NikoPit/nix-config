{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qq
    nixfmt
    killall
  ];
}
