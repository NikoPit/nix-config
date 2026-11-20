{ pkgs, ... }:

let
  releaseUrl = "https://github.com/NikoPit/misc-resources/releases/download/wallpaper-2687871416-v1";

  wallpaper = pkgs.fetchzip {
    url = "${releaseUrl}/wallpaper.tar.gz";
    hash = "sha256-dATzCcDgZUk3sgscNdmgwwxzbP78r/piq72ThejY5gs=";
  };

  assets = pkgs.fetchzip {
    url = "${releaseUrl}/wpe-assets.tar.gz";
    hash = "sha256-o+2S5DdmsFAN1PnyVUh2SpxLotKn5aPC/nNRh3Mqb9g=";
  };
in
{
  services.rxwpe = {
    enable = true;
    settings = {
      wallpaper = toString wallpaper;
      assets = toString assets;
    };
  };
}
