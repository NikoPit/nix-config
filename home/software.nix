{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xclicker
    v2raya
    jdk21
    modrinth-app
    linux-wallpaperengine
    qq
    discordo
    gh
    wineWowPackages.stable
    bottles
    unzip
    killall
  ];  
}
