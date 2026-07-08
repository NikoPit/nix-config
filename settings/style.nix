{ pkgs, ... }:
{
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/x6/wallhaven-x6vlw3.jpg";
    hash = "sha256-mfnEiKK7vE4jQrNOnzsZYVsrYPHLmBHNURJDPkfLsQ0=";
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
