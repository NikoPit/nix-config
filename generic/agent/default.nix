{ config, pkgs, ... }:

{
  sops.secrets.e-flowcode-gpt-apikey = { };

  programs.codex = {
    enable = true;
    mutableSettings = true;

    context = ./AGENTS.md;

    settings = {
      sandbox_mode = "danger-full-access";
      approval_policy = "never";

      model_provider = "e-flowcode";
      model_reasoning_effort = "high";

      model_providers.e-flowcode = {
        name = "e-flowcode";
        base_url = "https://e-flowcode.cc/v1";
        wire_api = "responses";

        auth = {
          command = "${pkgs.coreutils}/bin/cat";
          args = [ config.sops.secrets.e-flowcode-gpt-apikey.path ];
        };
      };
    };
  };
}
