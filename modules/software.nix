{ pkgs, ... }:

{
  home.packages = with pkgs; [
    qq
    gh
    nixfmt
    nodejs
    python3
    killall
  ];
}
