{
  services.linux-wallpaperengine = {
    enable = true;
    assetsPath = ../wallpaper;

    wallpapers = [ {
      monitor = "DP-3";
      wallpaperId = "3203778110";
      scaling = "default";
      audio = {
#        silent = true;
#	processing = false;
      };
    } ];
  };
}
