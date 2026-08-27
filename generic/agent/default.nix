{ pkgs, ... }:

{
  programs.pi-coding-agent = {
    enable = true;

    context = ./AGENTS.md;

    extraPackages = [ pkgs.nodejs ];

    settings = {
      packages = [
        "npm:pi-web-access"
        "npm:pi-subagents"
        "npm:@narumitw/pi-goal"
      ];

      hideThinkingBlock = true;

      defaultProvider = "openrouter";
      defaultModel = "deepseek/deepseek-v4-flash-0731";
    };
  };

  home.file = {
    ".pi/agent/skills" = {
      source = ./skills;
      recursive = true;
    };

    ".pi/agent/prompts" = {
      source = ./prompts;
      recursive = true;
    };

    ".pi/agent/extensions" = {
      source = ./extensions;
      recursive = true;
    };

    ".pi/web-search.json".text = builtins.toJSON {
      workflow = "auto-summary";
    };
  };

  imports = [
    ./mcp.nix
    ./providers.nix
  ];
}
