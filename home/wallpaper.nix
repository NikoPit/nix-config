{
  services.linux-wallpaperengine = {
    enable = true;
    assetsPath = ../wallpaper;
    clamping = "clamp";

    wallpapers = [ {
      monitor = "DP-3";
      wallpaperId = "3203778110";
      scaling = "default";
      fps = 60;
      audio = {
#        silent = true;
#	processing = false;
      };
    } ];
  };
}
