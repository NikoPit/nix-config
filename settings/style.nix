{ pkgs, ... }:
{
  wallpaper = pkgs.fetchurl {
    url = "https://pic4.zhimg.com/v2-a7ec38bf8c2b14f9a4eb22dd6108c289_1440w.jpg";
    hash = "sha256-p+bNdVAkXUgv5G4MkMC5zucumEto4w9r0rsTnTIi4kU=";
  };
  polarity = "light";

  font = {
    package = pkgs.maple-mono.NF-CN;
    name = "Maple Mono NF CN";
  };

  cursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };
}
