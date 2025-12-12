{
  programs.nixvim = {
    enable = true;

    imports = [
      ./clipboard.nix
    ];
  };
}
