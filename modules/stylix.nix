{ settings, ... }:
let
  styleSettings = settings.style;
in
{
  stylix = {
    enable = true;

    image = styleSettings.wallpaper;
    polarity = styleSettings.polarity;
    cursor = styleSettings.cursor;

    fonts = {
      serif = styleSettings.font;
      sansSerif = styleSettings.font;
      monospace = styleSettings.font;
      emoji = styleSettings.font;
    };
  };
}
