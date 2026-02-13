{lib, ...}:

{
  plugins = {
  dap-ui.enable = true;
  dap-virtual-text.enable = true;
  dap = {
    enable = true;

  };
  };

  extraConfigLua = ''
local dap = require("dap")
  dap.adapters.gdb = {
    type = "executable",
    command = "gdb-multiarch", -- 或者 x86_64-elf-gdb
    args = { "--interpreter=dap", "--eval-command", "set pagination off" }
}

-- 配置调试目标
dap.configurations.rust = {
    {
        name = "Attach to QEMU",
        type = "gdb",
        request = "attach",
        target = "localhost:1234", -- 对应 qemu 的 -s 参数
        -- 指向你编译出来的带调试信息的 ELF 文件
        program = function()
            return vim.fn.getcwd() .. "/target/x86_64-unknown-none/debug/your_kernel_name"
        end,
        cwd = "{workspaceRoot}",
        stopOnEntry = false,
    },
}
'';
}
