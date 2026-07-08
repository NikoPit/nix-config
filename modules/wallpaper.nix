{ pkgs, ... }:

let
  wallpaperId = "2687871416";
in
{
  services.linux-wallpaperengine = {
    enable = true;

    wallpapers = [
      {
        monitor = "DP-3";
        audio = {
          silent = true;
          processing = false;
        };

        extraOptions = [ "--disable-particles" ];

        inherit wallpaperId;
      }
    ];
  };
}
