{ pkgs, ... }:
let
  colorscheme = {
    base00 = "09111d";
    base01 = "111d31";
    base02 = "1a2a42";
    base03 = "4b5d78";
    base04 = "8392ab";
    base05 = "d8dbe3";
    base06 = "eceaf2";
    base07 = "faf6f0";

    base08 = "c97a72";
    base09 = "d8a25f";
    base0A = "e7cf84";
    base0B = "5d8f78";
    base0C = "5e9ea8";
    base0D = "6484e0";
    base0E = "8a78f0";
    base0F = "8a6a58";
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

    polarity = "light";
    cursor = {
      name = "Bibata-Modern-Classic";
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
