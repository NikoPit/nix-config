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
    go-musicfox
    nodejs
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
    gnumake
    xorriso
    cpio
    localsend
  ];
}
