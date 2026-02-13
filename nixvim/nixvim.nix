{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    imports = [
      ./clipboard.nix
      ./lualine.nix
      ./colorschemes.nix
      ./bufferline.nix
      ./keymaps.nix
      ./debugging.nix
      ./avante.nix
      ./lsp.nix
      ./misc.nix
      ./completion.nix
      ./diagnostic.nix
      ./transparent.nix
      ./telescope.nix
      ./auto-format.nix
    ];
  };
}
