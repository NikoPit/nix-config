{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xclicker
    v2rayn
    jdk21
    modrinth-app
    qq
    gh
    wineWowPackages.stable
    unzip
    killall
    fd
    pavucontrol
    nautilus
    vesktop
    cargo
    rustc
  ];  
}
