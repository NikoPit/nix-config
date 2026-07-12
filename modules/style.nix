{ pkgs, settings, ... }:
let
  palette = settings.palette;

  colorscheme = {
    base00 = palette.bg0;
    base01 = palette.bg1;
    base02 = palette.bg2;
    base03 = palette.bg3;
    base04 = palette.fg0;
    base05 = palette.fg1;
    base06 = palette.fg2;
    base07 = palette.fg3;

    base08 = palette.red0;
    base09 = palette.gold0;
    base0A = palette.gold1;
    base0B = palette.green0;
    base0C = palette.teal0;
    base0D = palette.blue0;
    base0E = palette.violet0;
    base0F = palette.brown0;
  };

  font = {
    package = pkgs.maple-mono.NF-CN;
    name = "Maple Mono NF CN";
  };
in
{
  stylix = {
    enable = true;

    base16Scheme = colorscheme;
    polarity = "dark";

    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/NikoPit/misc-resources/main/wallpaper_roxy.png";
      hash = "sha256-D1eOlqI8Yv+BkrwnNj7kd7gEvGGpfFGl663DbNi4or4=";
    };

    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    fonts = {
      serif = font;
      sansSerif = font;
      monospace = font;
      emoji = font;
    };

    opacity = {
      terminal = 0.5;
      applications = 0.8;
      desktop = 0.9;
      popups = 0.7;
    };
  };
}
