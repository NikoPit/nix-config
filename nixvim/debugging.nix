{lib, ...}:

{
  plugins = {
  dap-ui.enable = true;
  dap-virtual-text.enable = true;
  dap = {
    enable = true;
  };

  extraConfigLua = ''
  local dap = require("dap")

dap.adapters.gdb = {
    type = "executable",
    command = "rust-gdb", -- 或者 x86_64-elf-gdb
    args = { "--interpreter=dap", "--eval-command", "set pagination off" }
}

    dap.configurations.rust = dap.configurations.rust or {}

dap.configurations.rust = {
    {
        name = "Attach to QEMU",
        type = "gdb",
        request = "attach",
        target = "localhost:1234", 
        program = function()
            return vim.fn.getcwd() .. "/target/x86_64-elysia-os/debug/elysia-os"
        end,
        cwd = function()
	    return vim.fn.getcwd()
	end,    
        stopOnEntry = false,
    },
}
'';
};}
