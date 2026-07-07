{ pkgs, lib, ... }:

let
  roxyCodex = pkgs.symlinkJoin {
    name = "roxy-codex";
    paths = [ pkgs.codex ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/codex \
        --prefix PATH : ${
          lib.makeBinPath [
            pkgs.ripgrep
            pkgs.python3
            pkgs.nodejs
          ]
        }
    '';
  };
in
{
  programs.codex = {
    enable = true;
    enableMcpIntegration = true;
    package = roxyCodex;

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
