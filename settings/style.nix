{ pkgs, ... }:
{
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/72/wallhaven-72kyke.jpg";
    hash = "sha256-VVRDHdgMJPHTQRaeamcKf2oqp1UeZgVJPkwyrmLymnE=";
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
