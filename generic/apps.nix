{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
    ripgrep
    aria2
    mpv
    concord-tui
    bat
  ];
}
