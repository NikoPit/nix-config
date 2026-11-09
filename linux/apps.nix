{ pkgs, ... }:

{
  home.packages = with pkgs; [
    killall
    lunar-client
    bolt-launcher
  ];
}
