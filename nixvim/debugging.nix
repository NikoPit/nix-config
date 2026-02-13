{lib, ...}:

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

  extraConfigLua = ''
  local dap = require("dap")
dap.configurations.rust = {
    {
        name = "Attach to QEMU",
        type = "gdb",
        request = "attach",
        target = "localhost:1234", 
        program = function()
            return vim.fn.getcwd() .. "/target/x86_64-unknown-none/debug/your_kernel_name"
        end,
        cwd = "{workspaceRoot}",
        stopOnEntry = false,
    },
}
'';
}
