{ pkgs, ... }:

{
  xdg.portal = {
      enable = true;

      extraPortals = [pkgs.xdg-desktop-portal-termfilechooser];

      config = {
        common."org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
        niri."org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      };
  };

  #programs.firefox.preferences."widget.use-xdg-desktop-portal.file-picker" = 1;

  home.sessionVariables.TERMCMD = "${pkgs.ghostty}/bin/ghostty --title='termfilechooser' -e";

  xdg.configFile."xdg-desktop-portal-termfilechooser/config" = {
    text = ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    '';
  };

}
