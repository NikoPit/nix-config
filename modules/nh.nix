{ settings, ... }:
{
  programs.nh = {
    enable = true;
    flake = settings.configPath;
  };

  programs.fish.shellAliases.ns = "nh os switch";
}
