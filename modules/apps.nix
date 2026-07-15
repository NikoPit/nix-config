{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qq
    killall
    ripgrep
  ];
}
