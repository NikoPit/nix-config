{ settings, ... }:
let
  styleSettings = settings.style;
in
{
  stylix = {
    enable = true;
    image = styleSettings.wallpaper;
    polarity = styleSettings.polarity;
  };
}
