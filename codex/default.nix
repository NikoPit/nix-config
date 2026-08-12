{ pkgs-master, ... }:

{
  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
    package = pkgs-master.codex;

    context = ./AGENTS.md;
    settings = import ./settings.nix;
  };
}
