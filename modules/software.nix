{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qq
    gh
    nixfmt
    killall
  ];
}
