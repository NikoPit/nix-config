{ config, pkgs, ... }:

{
  sops.secrets.e-flowcode-gpt-apikey = { };

  programs.codex = {
    enable = true;

    settings = {
      model_provider = "e-flowcode";

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
