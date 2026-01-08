{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    imports = [
      ./clipboard.nix
      ./lualine.nix
      ./colorschemes.nix
      ./bufferline.nix
    ];
  };
}
