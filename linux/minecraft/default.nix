{ pkgs, lib, config, ... }:

{
  nixcraft = {
    enable = true;

    client.shared = {
      account.refreshTokenPath = lib.mkDefault "${config.home.homeDirectory}/.tmp/refreshtoken";

      binEntry.enable = true;
      desktopEntry.enable = true;

      enableFastAssetDownload = true;

      gameOptions = import ./options.nix;
    };
  };

  imports = [
    ./instances
  ];
}
