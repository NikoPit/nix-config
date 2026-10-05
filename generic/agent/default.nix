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

      defaultProvider = "e-flowcode-gpt";
      defaultModel = "gpt-6.1-sol";
      defaultThinkingLevel = "high";

      # Hide the startup banner and the loaded-resources listing.
      quietStartup = true;

      # Hide tool results in the /tree navigator by default.
      treeFilterMode = "no-tools";

      retry = {
        enabled = true;
        baseDelayMs = 3000;
        maxAgentDelayMs = 3000;
        maxRetries = 1.0e308; # Basically infinite retries
      };
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
