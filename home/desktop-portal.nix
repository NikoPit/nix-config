{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;

    config = {
      common = {
        default = [ "gnome" ];
      };
    };

    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
}
