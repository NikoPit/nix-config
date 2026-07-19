{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qq
    killall
    lazygit
    ripgrep
    bolt-launcher
  ];
}
