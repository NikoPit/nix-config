{ pkgs, ... }:

let
  skyblockEnhanced = pkgs.fetchurl {
    url = "https://cdn.modrinth.com/data/e0oMrxjp/versions/6PJFLL4g/SkyBlock%20Enhanced-5.3.6.mrpack?mr_download_reason=standalone&mr_game_version=26.2&mr_loader=fabric";
    hash = "sha256-ybJBRhDyn6zRiJFrpPNPLJuQF5+cfzAIBMmgbcpxOHQ=";
  };
in
{
  enable = true;
  desktopEntry.name = "Skyblock";

  mrpack = {
    enable = true;
    file = skyblockEnhanced;
  };

  mods = [
    (pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/7mawGKlP/versions/vMAeJcdc/crittermod-0.10.1%2Bmc26.2.jar?mr_download_reason=standalone&mr_game_version=26.2&mr_loader=fabric";
      hash = "sha256-VNjUcr07KQJCjxRRUNvdcbgDJ9N3UBRlMCBnDjXQJiA=";
      name = "crittermod.jar";
    })

    (pkgs.fetchurl {
      url = "https://cdn.modrinth.com/data/jrPpQCNN/versions/tTXH7DX6/iconographic-1.0.0-beta.5-26.2%2Bd76258ce.jar?mr_download_reason=standalone&mr_game_version=26.2&mr_loader=fabric";
      hash = "sha256-W5cG9EIyaZDWb4UIlf35UH63IlNVHLnoWbf6D8kFoyc=";
      name = "iconographic.jar";
    })
  ];
}
