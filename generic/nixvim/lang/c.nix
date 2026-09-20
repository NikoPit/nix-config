{ pkgs, config, ... }:

{
  plugins = {
    treesitter.grammarPackages = [
      config.plugins.treesitter.package.builtGrammars.c
    ];

    conform-nvim.settings.formatters_by_ft = {
      c = [ "clang-format" ];

      # .h files are detected as cpp
      cpp = [ "clang-format" ];
    };

    lsp.servers.clangd.enable = true;
  };

  extraPackages = [ pkgs.clang-tools ];
}
