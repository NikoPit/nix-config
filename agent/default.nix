{
  programs.pi-coding-agent = {
    enable = true;

    context = ./AGENTS.md;
  };

  home.file.".pi/agent/skills" = {
    source = ./skills;
    recursive = true;
  };

  imports = [
    ./mcp.nix
    ./providers.nix
  ];
}
