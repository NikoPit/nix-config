{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    nixpkgs.useGlobalPackages = true;

    imports = [
      ./lualine.nix
      ./bufferline.nix
      ./keymaps.nix
      ./lsp.nix
      ./misc.nix
      ./completion.nix
      ./diagnostic.nix
      ./treesitter.nix
      ./telescope.nix
      ./auto-format.nix
    ];
  };
}
