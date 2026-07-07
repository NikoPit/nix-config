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

    opacity = {
      terminal = 0.5;
      applications = 0.8;
      desktop = 0.9
      popups = 0.7;
    };
  };
}
