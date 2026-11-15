{
  imports = [
    ./shell.nix
    ../shared/stylix.nix
  ];

  environment.motd = "";

  android-integration = {
    termux-open.enable = true;
    termux-open-url.enable = true;
    xdg-open.enable = true;
    termux-wake-lock.enable = true;
    termux-wake-unlock.enable = true;
  };
}
