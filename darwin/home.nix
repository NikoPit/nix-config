{
  targets.darwin = {
    linkApps.enable = false;
    copyApps.enable = true;
  };

  imports = [
    ./ns.nix
    ./ghostty.nix
    ./wallpaper.nix
  ];
}
