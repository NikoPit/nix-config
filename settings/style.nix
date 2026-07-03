{ pkgs, ... }:
{
  wallpaper = pkgs.fetchurl {
    url = "https://wall.alphacoders.com/big.php?i=1266440";
    hash = "sha256-MXbqu0gu0jCOHLMTTKPz9a4O1g1rmoE3x6u5azygoM4=";
  };
  polarity = "light";
}
