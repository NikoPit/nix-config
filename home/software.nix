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
    claude-code
    modrinth-app
    wechat-uos
    gnumake
    xorriso
    cpio
    localsend
    codex
  ];
}
