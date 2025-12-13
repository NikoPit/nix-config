{ pkgs, ... }:

{
  home.packages = with pkgs; [
    kitty
    xclicker
    v2raya
    jdk21
    modrinth-app
    linux-wallpaperengine
    qq
    discord
  ];  
}
