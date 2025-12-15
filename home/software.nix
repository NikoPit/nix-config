{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xclicker
    v2raya
    jdk21
    modrinth-app
    linux-wallpaperengine
    qq
    vesktop
  ];  
}
