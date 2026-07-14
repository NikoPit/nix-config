{ pkgs, lib, ... }:

{
  nixcraft = {
    enable = true;

    client.shared = {
      account.refreshTokenPath = "/home/elysia/.tmp/refreshtoken";

      binEntry.enable = true;
      desktopEntry.enable = true;

      enableFastAssetDownload = true;

      files."options.txt".source = import ./options.nix { inherit pkgs lib; };
    };
  };

  imports = [
    ./instances.nix
  ];
}
