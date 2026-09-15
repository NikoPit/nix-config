let
  wallpaperId = "2687871416";
in
{
  services.linux-wallpaperengine = {
    enable = true;
    audio = {
      silent = true;
      processing = false;
    };

    wallpapers = [
      {
        monitor = "DP-3";

        extraOptions = [
          "--disable-particles"
          "--no-fullscreen-pause"
        ];

        inherit wallpaperId;
      }
    ];
  };
}
