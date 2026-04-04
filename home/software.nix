{ pkgs, ... }:

{
  home.packages = with pkgs; [
    xclicker
    jdk21
    qq
    gh
    wineWowPackages.stable
    git
    nixfmt
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
    cargo
    rustc
    xray
    gcc
    ladybird
    pkg-config
    udev
    rustfmt
    libudev-zero
    claude-code
    wechat-uos
    gnumake
    xorriso
    cpio
    prismlauncher
  ];
}
