{ pkgs, ... }:

let
  skyblocker = pkgs.fetchurl {
    url = "https://cdn.modrinth.com/data/KmiWHzQ4/versions/Ozl4TOJn/Skyblocker%20Modpack-3.5.28.mrpack?mr_download_reason=standalone&mr_game_version=26.1.2&mr_loader=fabric";
    hash = "sha256-wW0Ds4f23/KPUg4yr03Xz5h8Tjs/Kpcoj4mhfZn/IGs=";
  };
in
{
  enable = true;
  desktopEntry.name = "Skyblock";
  assetHash = "sha256-Jblp3zLP6HOphGT2cWTFvuu+EBkdfdWei9CrGP0xaUc=";

  mrpack = {
    enable = true;
    file = skyblocker;
  };

  account.refreshTokenPath = "/home/elysia/.tmp/skyblocktoken";
}
