{ config, ... }:

{
  sops.secrets.mc-refresh-token = { };

  nixcraft = {
    enable = true;

    client = {
      shared = {
        account.refreshTokenPath = config.sops.secrets.mc-refresh-token.path;
      };

      instances = {
        latest = {
          enable = true;
          version = "1.21.1";
          desktopEntry.enable = true;
        };
      };
    };
  };
}
