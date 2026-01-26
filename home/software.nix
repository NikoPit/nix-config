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
    v2raya
    vesktop
    cargo
    rustc
    xray
  ];  
}
