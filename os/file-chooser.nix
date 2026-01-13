{ pkgs, ... }:

{

  xdg = {
    portal = {
      extraPortals = [pkgs.xdg-desktop-portal-termfilechooser];

      config = {
        common."org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
        niri."org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      };
    };
  };

  programs.firefox.preferences."widget.use-xdg-desktop-portal.file-picker" = 1;

  environment.variables.TERMCMD = "${pkgs.ghostty}/bin/ghostty --title='termfilechooser' -e";

}
