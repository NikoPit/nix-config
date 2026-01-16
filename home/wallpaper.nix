{ 
  services.linux-wallpaperengine = {
    enable = true;
    assetsPath = ../wallpaper/assets;
    
    wallpapers = [ {
      monitor = "DP-3";
      wallpaperId = "${../wallpaper/bg}";
      audio = {
        silent = true;
    	processing = false;
      };
    } ];
  };
}
