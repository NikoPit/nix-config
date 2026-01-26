{
  plugins.lsp = {
    enable = true;
    servers = {
      jdtls.enable = true;
      nixd.enable = true;
      rust-analyzer.enable = true;
    };
  };

  lsp.inleyHints.enable = true;
}
