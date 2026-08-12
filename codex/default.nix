{ pkgs-master, ... }:

{
  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
    package = pkgs-master.codex;

    context = ./AGENTS.md;
    skills = ./skills;
    settings = import ./settings.nix;
  };
}
