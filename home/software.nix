{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xclicker
    jdk21
    qq
    gh
    git
    nixfmt
    osu-lazer-bin
    python3
    gdb
    vscodium
    ripgrep
    ffmpeg
    unzip
    killall
    fd
    pavucontrol
    nautilus
    vesktop
    rustup
    xray
    gcc
    ladybird
    pkg-config
    udev
    libudev-zero
    modrinth-app
    gnumake
    xorriso
    cpio
    localsend
  ];
}
