{ pkgs, ... }:

{
  programs.pi-coding-agent = {
    enable = true;

    context = ./AGENTS.md;

    extraPackages = with pkgs; [
      nodejs
      gh
      wl-clipboard
      python3
    ];

    settings = {
      packages = [
        "npm:pi-web-access"
        "npm:pi-subagents"
        "npm:@narumitw/pi-goal"
        "npm:@narumitw/pi-btw"
        "npm:@juicesharp/rpiv-ask-user-question"
        "npm:pi-vim"
        "npm:pi-collapse-tools"
      ];

      defaultProvider = "e-flowcode-cn";
      defaultModel = "deepseek-v4.1-flash";
      defaultThinkingLevel = "low";
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
