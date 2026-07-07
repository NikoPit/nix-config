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
      terminal = 0.7;
      applications = 0.95;
      desktop = 1.0;
      popups = 0.9;
    };
  };
}
