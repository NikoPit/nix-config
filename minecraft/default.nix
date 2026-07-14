{
  nixcraft = {
    enable = true;

    client.shared = {
      account.refreshTokenPath = "/home/elysia/.tmp/refreshtoken";
      binEntry.enable = true;
    };
  };

  imports = [
    ./instances.nix
  ];
}
