{ pkgs, config, ... }:

{
  plugins = {
    treesitter.grammarPackages = [
      config.plugins.treesitter.package.builtGrammars.c
    ];

    conform-nvim.settings.formatters_by_ft.c = [ "clang-format" ];

    lsp.servers.clangd.enable = true;
  };

  extraPackages = [ pkgs.clang-tools ];
}
