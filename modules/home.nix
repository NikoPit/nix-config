{ settings, ... }:
{
  home = {
    username = settings.user.name;
    homeDirectory = "/home/${settings.user.name}";
    stateVersion = "25.05";
  };

  imports = [
    ./software.nix
    ./firefox.nix
    ./fastfetch.nix
    ./nh.nix
    ./direnv.nix
    ./git.nix
    ./mcp.nix
    ./codex.nix
    ./input-method.nix
    ./wayle.nix
    ./screenshot.nix

    ./app-launcher.nix
    ./file-manager.nix
    ./terminal.nix
  ];
}
