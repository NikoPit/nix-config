{ config, ... }:

{
  programs.pi-coding-agent.models.providers = {
    e-flowcode-gpt = {
      headers.User-Agent = "codex_cli_rs/0.77.0 (Windows 10.0.26100; x86_64) WindowsTerminal";
      baseUrl = "https://e-flowcode.cc/v1";
      api = "openai-completions";
      apiKey = "!cat ${config.sops.secrets.e-flowcode-gpt-apikey.path}";

      models = [
        {
          id = "gpt-5.6-sol";
          name = "GPT-5.6 Sol";
          reasoning = true;
        }
      ];
    };

    e-flowcode-cn = {
      headers.User-Agent = "codex_cli_rs/0.77.0 (Windows 10.0.26100; x86_64) WindowsTerminal";
      baseUrl = "https://e-flowcode.cc/v1";
      api = "openai-completions";
      apiKey = "!cat ${config.sops.secrets.e-flowcode-cn-apikey.path}";

      models = [
        {
          id = "glm-5.2";
          name = "GLM-5.2";
          reasoning = true;
        }

        {
          id = "deepseek-v4-flash";
          name = "Deepseek V4 Flash";
          reasoning = true;
        }

        {
          id = "kimi-k3";
          name = "Kimi K3";
          reasoning = true;
        }
      ];
    };

    deepseek = {
      baseUrl = "https://api.deepseek.com";
      api = "openai-completions";
      apiKey = "!cat ${config.sops.secrets.deepseek-apikey.path}";

      models = [
        {
          id = "deepseek-v4-flash";
          name = "Deepseek V4 Flash";
          reasoning = true;
        }
      ];
    };
  };

  sops.secrets = {
    e-flowcode-gpt-apikey = { };
    e-flowcode-cn-apikey = { };
    deepseek-apikey = { };
  };
}
