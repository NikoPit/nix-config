{ pkgs, ... }:
{
  plugins.telescope = {
    enable = true;
  };

  # Installs ripgrep for telescope's live_grep
  extraPackages = [ pkgs.ripgrep ];
}
