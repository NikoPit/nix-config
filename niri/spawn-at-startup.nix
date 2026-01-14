{ pkgs, ... }:

{
  programs.niri.settings.spawn-at-startup = [
      # TODO: make the path to wallpaper a nix path (with ${../wallpaper} or something)
      { sh = "${pkgs.linux-wallpaperengine}/bin/linux-wallpaperengine ~/nix/wallpaper --screen-root DP-3 --silent --no-audio-processing --no-fullscreen-pause"; }
  ];
}
