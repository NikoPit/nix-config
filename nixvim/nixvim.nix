{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    nixpkgs.useGlobalPackages = true;

    imports = [
      ./clipboard.nix
      ./lualine.nix
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
