{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mpv
    discord
    killall
  ];
}
