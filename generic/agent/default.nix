{ pkgs, ... }:

let
  piMainSrc = pkgs.fetchFromGitHub {
    owner = "earendil-works";
    repo = "pi";
    rev = "661619e87277d92caa2af71960112d9d92c13a5c";
    hash = "sha256-SetIfyIebHfLPS+0QAhqGhxtRdKFgnwwFxMwTsiYAgA=";
  };

  # Package targeting the `main` branch of pi, having the latest changes.
  piMain = pkgs.pi-coding-agent.overrideAttrs {
    src = piMainSrc;
    npmDeps = pkgs.fetchNpmDeps {
      name = "pi-coding-agent-master-npm-deps";
      hash = "sha256-3ds7N8i1fopSsxCW/MKY6WEaV644qjxkJYRsq0BgWes=";

      src = piMainSrc;
    };
  };
in
{
  programs.pi-coding-agent = {
    enable = true;
    package = piMain;

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
      defaultModel = "gpt-6-sol";
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
