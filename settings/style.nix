{ pkgs, ... }:
{
  wallpaper = pkgs.fetchurl {
    url = "https://images4.alphacoders.com/133/thumb-1920-1336916.png";
    hash = "sha256-RGC3pp4LRI7KC8Is4rIlMuLVhg+xTjW8Y76Tckfvu7s=";
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
