{ pkgs, ... }:
let
  colorscheme = {
    base00 = "f7f2ee"; # main background
    base01 = "efe6df"; # lighter panel background
    base02 = "e3d7cf"; # selection / subtle borders
    base03 = "b7aaa1"; # comments / disabled
    base04 = "8c8079"; # muted foreground
    base05 = "5e5652"; # main foreground
    base06 = "4d4643"; # stronger foreground
    base07 = "3c3735"; # highest contrast text

    base08 = "c46a55"; # red / coral
    base09 = "d88d6d"; # orange / warm accent
    base0A = "d9c27a"; # yellow / soft gold
    base0B = "a7b97d"; # green / sage
    base0C = "8fbfbc"; # cyan / pale mint
    base0D = "7d88b5"; # blue / dusty periwinkle
    base0E = "b48db6"; # purple / mauve
    base0F = "c89d8f"; # extra accent / blush brown
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

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/e7/wallhaven-e76wvl.jpg";
      hash = "sha256-vAJ7dApaEIdoNf0vHfQ/+Kq/Ll0VbxMyv6xZyyW0w/s=";
    };
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
