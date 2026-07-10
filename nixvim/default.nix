{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    nixpkgs.useGlobalPackages = true;

    imports = [
      ./statusline.nix
      ./bufferline.nix
      ./keymaps.nix
      ./lsp.nix
      ./lang
      ./terminal.nix
      ./misc.nix
      ./completion.nix
      ./diagnostic.nix
      ./treesitter.nix
      ./telescope.nix
      ./auto-format.nix
    ];
  };

  imports = [ ./style.nix ];
}
