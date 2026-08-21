{ pkgs, ... }:

{
  programs.mcp = {
    enable = true;

    servers = {
      git.command = "${pkgs.mcp-server-git}/bin/mcp-server-git";
      context7.command = "${pkgs.context7-mcp}/bin/context7-mcp";
      nixos.command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
      playwright.command = "${pkgs.playwright-mcp}/bin/playwright-mcp";
    };
  };
}
