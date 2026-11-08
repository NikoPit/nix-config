{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qq
    killall
    lunar-client
    bolt-launcher
  ];
}
