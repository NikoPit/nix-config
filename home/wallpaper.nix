{ pkgs, ... }:

{
  services.linux-wallpaperengine = {
    enable = true;
    
    # TODO: WIP
    #wallpapers = [ {
    #  monitor = "DP-3";
    #  backgroundId = "3203778110";
    #  audio = {
    #    silent = true;
    #	processing = false;
    #  };
    #} ];
  };

  programs.niri.settings.spawn-at-startup = [{ sh = "${pkgs.linux-wallpaperengine}/bin/linux-wallpaperengine ../wallpaper/3203778110 
    --screen-root DP-3 --silent --no-audio-processing --no-fullscreen-pause"; }];
}
