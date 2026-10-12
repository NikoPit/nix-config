{ lib, ... }:

{
  nixcraft = {
    enable = true;

    client.shared = {
      account = lib.mkDefault {
        offline = false;
        uuid = "0f8fbc078fa34ac498672dbf28ea62b0";
        username = "_RoxyBestGirl";
      };

      binEntry.enable = true;
      desktopEntry.enable = true;

      optionsTxt = import ./options.nix;
    };
  };

  imports = [
    ./instances
  ];
}
