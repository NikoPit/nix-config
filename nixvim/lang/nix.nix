{ config, ... }:

{
  plugins.treesitter.grammarPackages = [
    config.plugins.treesitter.package.builtGrammars.nix
  ];
}
