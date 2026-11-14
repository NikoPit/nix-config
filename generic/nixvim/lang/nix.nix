{ config, pkgs, ... }:

{
  files."after/ftplugin/nix.lua".localOpts = {
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
  };

  plugins = {
    treesitter.grammarPackages = [
      config.plugins.treesitter.package.builtGrammars.nix
    ];

    conform-nvim.settings.formatters_by_ft.nix = [ "nixfmt" ];
  };

  extraPackages = [ pkgs.nixfmt ];
}
