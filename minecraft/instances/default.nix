{ pkgs, ... }:

{
  nixcraft.client.instances = {
    "FishOnMC" = {
      enable = true;

      version = "1.21.11";
      assetHash = "sha256-GaqxPrc5xgjlXQDXYyYsES4mYDI0wpvabos7rZHoEXU=";

      desktopEntry.name = "Fish On MC";
    };

    "HarrysPit" = {
      enable = true;

      version = "1.8.9";
      assetHash = "sha256-aZu7DkjlpUqITM9qMeZ8gVYzNFkmm1UhiorevYUGxwg=";

      desktopEntry.name = "Harrys Pit";
    };

    "LiquidBounce" = import ./liquidbounce.nix { inherit pkgs; };
  };
}
