{ pkgs, pkgs-master, ... }:

{
  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
    package = pkgs-master.codex;

    settings = {
      model = "gpt-5.4";
      model_provider = "e-flowcode";

      sandbox_mode = "danger-full-access";
      approval_policy = "never";
      projects."/".trust_level = "trusted";

      model_providers.e-flowcode = {
        name = "e-flowcode";
        base_url = "https://e-flowcode.cc/v1";
        wire_api = "responses";
        requires_openai_auth = true;

        request_max_retries = 100;
        stream_max_retries = 100;
      };
    };
  };

  xdg.desktopEntries.codex = {
    name = "Codex";
    genericName = "Command Line Tool";
    exec = "${pkgs.codex}/bin/codex";
    terminal = true;
  };
}
