{ pkgs, lib, ... }:

{
  nixcraft = {
    enable = true;

    client.shared = {
      account.refreshTokenPath = "/home/elysia/.tmp/refreshtoken";

      binEntry.enable = true;
      desktopEntry.enable = true;

      enableFastAssetDownload = true;

      gameOptions = import ./options.nix;
    };
  };

  imports = [
    ./instances.nix
  ];
}
