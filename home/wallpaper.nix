{ display, ... }:

{ 
  services.linux-wallpaperengine = {
    enable = true;
    assetsPath = ../wallpaper/assets;
    clamping = "clamp";
    
    wallpapers = [ {
      monitor = "${display}";
      wallpaperId = "${../wallpaper/bg}";
      audio = {
        silent = true;
    	processing = false;
      };
    } ];
  };
}
