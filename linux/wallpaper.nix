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

  systemd.user.services.linux-wallpaperengine.Service = {
    RuntimeMaxSec = "90m";
    RuntimeRandomizedExtraSec = "10m";
    RestartSec = "5s";

    MemoryHigh = "5G";
    MemoryMax = "6G";
    MemorySwapMax = "0";
  };
}
