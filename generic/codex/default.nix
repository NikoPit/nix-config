{
  config,
  lib,
  pkgs,
  ...
}:

{
  sops.secrets.e-flowcode-gpt-apikey = { };

  programs.codex = {
    enable = true;
    mutableSettings = true;

    context = ./AGENTS.md;

    extraPackages = with pkgs; [
      python3
      nodejs
      jq
    ];

    settings = {
      sandbox_mode = "danger-full-access";
      approval_policy = "never";
      check_for_update_on_startup = false;

      model_provider = "e-flowcode";
      model_reasoning_effort = "high";

      agents.max_concurrent_threads_per_session = 64;

      tui.show_tooltips = false;

      model_providers.e-flowcode = {
        name = "e-flowcode";
        base_url = "https://e-flowcode.cc/v1";
        wire_api = "responses";

        auth = {
          command = lib.getExe' pkgs.coreutils "cat";
          args = [ config.sops.secrets.e-flowcode-gpt-apikey.path ];
        };
      };
    };
  };
}
