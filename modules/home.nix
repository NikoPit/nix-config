{ settings, ... }:
{
  home = {
    username = settings.user.name;
    homeDirectory = "/home/${settings.user.name}";
    stateVersion = "25.05";
  };

  imports = [
    ./apps.nix

    ./firefox.nix
    ./fastfetch.nix
    ./nh.nix
    ./direnv.nix
    ./git.nix
    ./mcp.nix
    ./codex.nix
    ./wayle.nix

    ./screenshot.nix
    ./app-launcher.nix
    ./wallpaper.nix
    ./file-manager.nix
    ./terminal.nix

    ./input-method.nix
  ];
}
