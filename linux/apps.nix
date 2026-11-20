{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lunar-client
    bolt-launcher
    wine
  ];
}
