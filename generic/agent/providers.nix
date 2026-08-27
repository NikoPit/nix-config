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
          input = [
            "text"
            "image"
          ];
          contextWindow = 1050000; # treated as 1M: verified 354K passes through the relay; native limit is 1.05M
          maxTokens = 128000;

          thinkingLevelMap = {
            off = "none";
            minimal = null;
            low = "low";
            medium = "medium";
            high = "high";
            xhigh = "xhigh";
            max = "max";
          };

          cost = {
            input = 5;
            output = 30;
            cacheRead = 0.5;
            cacheWrite = 6.25;
            tiers = [
              {
                inputTokensAbove = 272000;
                input = 10;
                output = 45;
                cacheRead = 1;
                cacheWrite = 12.5;
              }
            ];
          };
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

    deepseek.apiKey = "!cat ${config.sops.secrets.deepseek-apikey.path}";

    openrouter = {
      apiKey = "!cat ${config.sops.secrets.openrouter-apikey.path}";

      modelOverrides = {
        "deepseek/deepseek-v4-flash-0731".compat.openRouterRouting = {
          order = [
            "baidu/fp8"
            "baseten/fp8"
          ];
          allow_fallbacks = true;
        };
      };
    };
  };

  sops.secrets = {
    e-flowcode-gpt-apikey = { };
    e-flowcode-cn-apikey = { };
    deepseek-apikey = { };
    openrouter-apikey = { };
  };
}
