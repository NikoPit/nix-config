{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
    ripgrep
    aria2
    concord-tui
    bat
    unar
    wine
  ];
}
