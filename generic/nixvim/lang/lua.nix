{
  plugins.lsp.servers.lua_ls.enable = true;

  files."after/ftplugin/lua.lua".localOpts = {
    expandtab = true;
    shiftwidth = 4;
    tabstop = 4;
    softtabstop = 4;
  };
}
