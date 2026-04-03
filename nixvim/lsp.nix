{
  plugins.lsp = {
    enable = true;
    inleyHints = true;
    servers = {
      bashls.enable = true;
      jdtls.enable = true;
      nixd.enable = true;
      clangd.enable = true;
    };
  };
}
