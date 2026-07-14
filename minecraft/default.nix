{
  nixcraft = {
    enable = true;

    client.shared = {
      account.refreshTokenPath = "/home/elysia/.tmp/refreshtoken";

      binEntry.enable = true;
      desktopEntry.enable = true;

      enableFastAssetDownload = true;

    };
  };

  imports = [
    ./instances.nix
  ];
}
