{ pkgs, ... }:

let
  utils = import ./utils.nix;
in
{
  plugins.telescope = {
    enable = true;
  };

  # Installs ripgrep for telescope's live_grep
  extraPackages = [ pkgs.ripgrep ];

  keymaps = [
    (utils.makeShortcut {
      command = "Telescope live_grep";
      key = "<space>lg";
    })

    (utils.makeShortcut {
      command = "Telescope find_files";
      key = "<space>ff";
    })
  ];
}
