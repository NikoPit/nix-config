{ config, pkgs, ... }:

{
  plugins = {
    treesitter.grammarPackages = [
      config.plugins.treesitter.package.builtGrammars.zig
    ];

    conform-nvim.settings.formatters_by_ft.zig = [ "zigfmt" ];

    lsp.servers.zls.enable = true;
  };

  extraPackages = [ pkgs.zig ];
}
