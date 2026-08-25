let
  utils = import ./utils.nix;
in
{
  plugins.bufferline = {
    enable = true;

    settings.options = {
      show_buffer_close_icons = false;
      show_close_icon = false;
    };
  };

  keymaps = [
    (utils.makeShortcut {
      command = "bnext";
      key = "<tab>";
    })

    (utils.makeShortcut {
      command = "bd";
      key = "<space>x";
    })
  ];
}
