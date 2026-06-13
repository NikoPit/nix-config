{ pkgs, ... }:

{
  programs.mcp = {
    enable = true;
    servers = {
      git.command = "${pkgs.mcp-server-git}/bin/mcp-server-git";
      fetch.command = "${pkgs.mcp-server-fetch}/bin/mcp-server-fetch";
      context7.command = "${pkgs.context7-mcp}/bin/context7-mcp";
      nixos.command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
      mcp-qemu-lab = {
        command = "${pkgs.uv}/bin/uvx";
        args = [
          "--from"
          "git+https://github.com/Kevin4562/QEMU-MCP.git@main"
          "mcp-qemu-lab"
        ];
        env = {
          MCP_QEMU_LAB_WORKSPACE = "/home/elysia/.local/share/mcp-qemu-lab";
          UV_PYTHON = "${pkgs.python3}/bin/python3";
        };
      };
      qemu-vm-control = {
        command = "${pkgs.writeShellScript "qemu-vm-control-mcp-wrapper" ''
          set -euo pipefail

          repo="''${MCP_QEMU_VM_REPO:-$HOME/.local/share/mcp-qemu-vm}"
          if [ ! -d "$repo/.git" ]; then
            mkdir -p "$(dirname "$repo")"
            ${pkgs.git}/bin/git clone --depth 1 https://github.com/Neanderthal/mcp-qemu-vm.git "$repo"
          fi

          export UV_PYTHON="${pkgs.python3}/bin/python3"
          cd "$repo"
          exec ${pkgs.uv}/bin/uv run python "$repo/server.py"
        ''}";
        env = {
          VM_HOST = "192.168.122.79";
          VM_USER = "vmrobot";
          VM_PORT = "22";
          VM_DISPLAY = ":0";
        };
      };
      github = {
        command = "${pkgs.writeShellScript "github-mcp-server-wrapper" ''
          export GITHUB_PERSONAL_ACCESS_TOKEN="$(${pkgs.gh}/bin/gh auth token)"
          exec ${pkgs.github-mcp-server}/bin/github-mcp-server "$@"
        ''}";
        args = [
          "stdio"
        ];
      };

      rust-analyzer = {
        command = "${pkgs.mcp-language-server}/bin/mcp-language-server";
        args = [
          "-workspace"
          "."
          "-lsp"
          "${pkgs.rust-analyzer}/bin/rust-analyzer"
        ];
      };

    };
  };
}
