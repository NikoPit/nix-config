{ pkgs, ... }:

let
  wynncarft-for-lunar-client = pkgs.fetchurl {
    url = "https://cdn.modrinth.com/data/cqIwxyhH/versions/nTTPMzjO/Wynncraft%20for%20Lunar%20Client%200.0.16.mrpack?mr_download_reason=standalone&mr_game_version=1.21.11&mr_loader=fabric";
    hash = "sha256-IXCK8eJr1Ias37zdqoA3/9IxKq7Fi2D9v9dXl1mzbbE=";
  };
in
{
  enable = true;
  desktopEntry.name = "Wynncraft";
  assetHash = "sha256-GaqxPrc5xgjlXQDXYyYsES4mYDI0wpvabos7rZHoEXU=";

  mrpack = {
    enable = true;
    file = wynncarft-for-lunar-client;
  };
}
