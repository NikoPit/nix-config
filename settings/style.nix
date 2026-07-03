{ pkgs, ... }:
{
  wallpaper = pkgs.fetchurl {
    url = "https://wall.alphacoders.com/big.php?i=1266440";
    hash = "";
  };
  polarity = "light";
}
