{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xclicker
    v2raya
    jdk21
    modrinth-app
    qq
    gh
    wineWowPackages.stable
    unzip
    killall
    vesktop
  ];  
}
