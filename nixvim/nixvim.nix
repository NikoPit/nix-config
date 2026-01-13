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
      ./lsp.nix
      ./misc.nix
    ];
  };
}
