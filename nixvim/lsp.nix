{
  plugins.lsp = {
    enable = true;
    inleyHints = true;
    servers = {
      jdtls.enable = true;
      nixd.enable = true;
      rust-analyzer.enable = true;
    };
  };
}
