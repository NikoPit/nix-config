{ pkgs, ... }:
{
  plugins.telescope = {
    enable = true;
  };

  # Installs ripgrep for telescope's live_grep
  extraPackages = [ pkgs.ripgrep ];

  keymaps = [
    {
      action = "<cmd>Telescope live_grep<cr>";
      key = "<space>lg";
    }
  ];
}
