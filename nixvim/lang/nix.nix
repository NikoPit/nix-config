{ config, ... }:

{
  plugins = {
    treesitter.grammarPackages = [
      config.plugins.treesitter.package.builtGrammars.nix
    ];

    conform-nvim.settings.formatters_by_ft.nix = [ "nixfmt" ];
  };
}
