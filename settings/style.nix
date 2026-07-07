{ pkgs, ... }:
{
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/e7/wallhaven-e78jg8.jpg";
    hash = "sha256-bhIibvzvDKmFgQKS/G+sK2ah2Y21NPfi8IhBSZLpiEM=";
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
