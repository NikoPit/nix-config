{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lazygit
    ripgrep
    transmission_4
    mpv
    concord-tui
  ];
}
