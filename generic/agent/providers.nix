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
          id = "glm-5.3-flash";
          name = "GLM-5.3-Flash";
          reasoning = true;
          input = [
            "text"
            "image"
          ];
          contextWindow = 1048576;
          maxTokens = 131072;

          thinkingLevelMap = {
            off = null;
            minimal = null;
            low = "low";
            medium = null;
            high = "high";
            xhigh = null;
            max = "max";
          };

          # data reused from pi's fetched openrouter metadata (z-ai/glm-5.3-flash):
          # contextWindow 1M, maxTokens 131072, text+image input, USD per 1M tokens
          cost = {
            input = 0.075;
            output = 0.25;
            cacheRead = 0.015;
            cacheWrite = 0;
          };
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
          input = [
            "text"
            "image"
          ];
          contextWindow = 1048576;
          maxTokens = 131072;

          thinkingLevelMap = {
            off = "none";
            minimal = null;
            low = "low";
            medium = null;
            high = "high";
            xhigh = null;
            max = "max";
          };

          cost = {
            input = 3;
            output = 15;
            cacheRead = 0.3;
            cacheWrite = 0;
          };
        }
      ];
    };

    e-flowcode-gemini = {
      headers.User-Agent = "codex_cli_rs/0.77.0 (Windows 10.0.26100; x86_64) WindowsTerminal";
      baseUrl = "https://e-flowcode.cc/v1";
      api = "openai-completions";
      apiKey = "!cat ${config.sops.secrets.e-flowcode-gemini-apikey.path}";

      models = [
        {
          id = "gemini-3.7-flash";
          name = "Gemini 3.7 Flash";
          reasoning = true;
          input = [
            "text"
            "image"
          ];
          contextWindow = 1048576;
          maxTokens = 65536;

          thinkingLevelMap = {
            off = null;
            minimal = null;
            low = "low";
            medium = "medium";
            high = "high";
            xhigh = null;
            max = null;
          };

          cost = {
            input = 0.375;
            output = 1.875;
            cacheRead = 0.0375;
            cacheWrite = 0.020833;
          };
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
    e-flowcode-gemini-apikey = { };
    deepseek-apikey = { };
    openrouter-apikey = { };
  };
}
