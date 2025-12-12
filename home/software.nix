{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vim
    kitty
    v2raya
    jdk21
    modrinth-app
    linux-wallpaperengine
    vesktop
  ];  
}
