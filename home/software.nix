{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    v2raya
    jdk21
    modrinth-app
    linux-wallpaperengine
    qq
    discord
  ];  
}
