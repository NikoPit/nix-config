{ settings, ... }:
{
  home = {
    username = settings.user.name;
    homeDirectory = "/home/${settings.user.name}";
    stateVersion = "25.05";
  };

  imports = [
    ./software.nix
    ./ghostty.nix
    ./firefox.nix
    ./rofi.nix
    ./fastfetch.nix
    ./nh.nix
    ./direnv.nix
    ./git.nix
    ./mcp.nix
    ./codex.nix
    ./input-method.nix
    ./yazi.nix
    ./wayle.nix
    ./screenshot.nix
  ];
}
