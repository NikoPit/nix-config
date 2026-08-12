{ pkgs-master, ... }:

{
  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
    package = pkgs-master.codex;

    settings = import ./settings.nix;
  };
}
