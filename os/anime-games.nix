{ aagl, ... }:
{
  imports = [ aagl.nixosModules.default ];

  programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
  programs.anime-games-launcher.enable = true;
  programs.honkers-railway-launcher.enable = true;
  programs.honkers-launcher.enable = true;
}
