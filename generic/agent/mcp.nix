{ pkgs, ... }:

{
  programs.mcp = {
    enable = true;

    servers = {
      context7.command = "${pkgs.context7-mcp}/bin/context7-mcp";
      nixos.command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
      playwright.command = "${pkgs.playwright-mcp}/bin/playwright-mcp";
    };
  };
}
