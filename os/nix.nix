{ settings, ... }:
{
  nix.settings = {
    warn-dirty = false;
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    gc = {
      automatic = true;
      dates = settings.nixGC.dates;
    };
  };

}
