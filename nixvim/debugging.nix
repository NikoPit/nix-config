{
  plugins = {
  dap-ui.enable = true;
  dap-virtual-text.enable = true;
  dap = {
    enable = true;

    executables.gdb = {
      command = "rust-gdb";
      args = ["-i" "dap"];
    };
  };
  };
}
