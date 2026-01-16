{
  services.linux-wallpaperengine = {
    enable = true;
    assetsPath = ../wallpaper;

    wallpapers = [ {
      monitor = "DP-3";
      wallpaperId = "1";
    } ];
  };
}
