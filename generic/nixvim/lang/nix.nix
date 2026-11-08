{ config, pkgs, ... }:

{
  autoCmd = [
    {
      event = [ "FileType" ];
      pattern = [ "nix" ];
      command = "setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2";
    }
  ];

  plugins = {
    treesitter.grammarPackages = [
      config.plugins.treesitter.package.builtGrammars.nix
    ];

    conform-nvim.settings.formatters_by_ft.nix = [ "nixfmt" ];
  };

  extraPackages = [ pkgs.nixfmt ];
}
