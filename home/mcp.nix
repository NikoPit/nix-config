{ pkgs, ... }:

{
  programs.mcp = {
    enable = true;
    servers = {
      git.command = "${pkgs.mcp-server-git}/bin/mcp-server-git";
      fetch.command = "${pkgs.mcp-server-fetch}/bin/mcp-server-fetch";
      context7.command = "${pkgs.context7-mcp}/bin/context7-mcp";
      nixos.command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
      seele = {
        command = "${pkgs.writeShellScript "seele-mcp-wrapper" ''
          set -euo pipefail

          cd /home/elysia/coding-project/seele-os-linux
          exec ${pkgs.nix}/bin/nix develop -c cargo run --quiet -p control-mcp
        ''}";
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
