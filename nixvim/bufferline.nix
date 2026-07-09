let
  utils = import ./utils.nix;
in
{
  plugins.bufferline = {
    enable = true;
  };

  keymaps = [
    (utils.makeShortcut {
      command = "bnext";
      key = "<tab>";
    })
  ];
}
