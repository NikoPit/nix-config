{ pkgs, ... }:

{
  programs.mcp = {
    enable = true;
    servers = {
      git.command = "${pkgs.mcp-server-git}/bin/mcp-server-git";
      fetch.command = "${pkgs.mcp-server-fetch}/bin/mcp-server-fetch";
      context7.command = "${pkgs.context7-mcp}/bin/context7-mcp";
      nixos.command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
      github.command = "${pkgs.github-mcp-server}/bin/github-mcp-server";

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
