{ pkgs, ... }:

{
  programs.pi-coding-agent = {
    enable = true;

    context = ./AGENTS.md;

    extraPackages = [ pkgs.nodejs ];

    settings.packages = [
      "npm:pi-web-access"
      "npm:pi-subagents"
      "npm:@narumitw/pi-goal"
      "npm:pi-lens"
    ];
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
