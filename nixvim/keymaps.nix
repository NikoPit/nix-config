{
  keymaps = [
    {
      action = "<cmd>Yazi<cr>";
      key = "<space>-";
      options.silent = true;
    }
    {
      action = "<cmd>Lspsaga term_toggle<cr>";
      key = "<A-x>";
      options.silent = true;
      mode = [
        "n"
        "t"
      ];
    }
    {
      action = "<cmd>LazyGit<cr>";
      key = "<space>g";
      options.silent = true;
    }
    {
      action = "<cmd>Lspsaga code_action<cr>";
      key = "<space>ca";
      options.silent = true;
    }
    {
      action = "<cmd>Telescope lsp_definitions<cr>";
      key = "gd";
    }
  ];
}
