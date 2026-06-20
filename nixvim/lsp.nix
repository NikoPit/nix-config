{
  plugins.lsp = {
    enable = true;
    inlayHints = true;
    servers = {
      bashls.enable = true;
      jdtls.enable = true;
      nixd.enable = true;
      clangd.enable = true;
    };
  };
}
