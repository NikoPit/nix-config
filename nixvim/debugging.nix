{ lib, ... }:

{
  plugins = {
    dap-ui.enable = true;
    dap-virtual-text.enable = true;
    dap = {
      enable = true;

      adapters = {
        executables.rust = {
          command = "rust-gdb";
          args = [
            "-i"
            "dap"
          ];
        };

      };
      configurations.rust = [
        {
          name = "Attach to QEMU";
          type = "rust";
          request = "attach";
          target = "localhost:1234";
          program = ''
            function()
                                            return vim.fn.getcwd() .. "/target/x86_64-elysia-os/debug/elysia-os"
                                        end,'';
          cwd = ''
            function()
                                	    return vim.fn.getcwd()
                                	end,    '';
          stopOnEntry = false;
        }
      ];

    };

  };
}
