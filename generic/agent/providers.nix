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

        {
          id = "gpt-6-astra";
          name = "GPT-6 Astra";
          reasoning = true;
          input = [
            "text"
            "image"
          ];
          contextWindow = 1050000; # OpenAI official: 1.05M context / 128K max output
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

          # OpenAI official pricing (Standard):
          # <=272K: input 10, cacheRead 1, cacheWrite 12.5, output 50
          #  >272K: input 20, cacheRead 2, cacheWrite 25,  output 75
          cost = {
            input = 10;
            output = 50;
            cacheRead = 1;
            cacheWrite = 12.5;
            tiers = [
              {
                inputTokensAbove = 272000;
                input = 20;
                output = 75;
                cacheRead = 2;
                cacheWrite = 25;
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
          input = [ "text" ];
          contextWindow = 1048576;
          maxTokens = 384000;

          thinkingLevelMap = {
            minimal = null;
            low = "low";
            medium = null;
            high = "high";
            max = "max";
          };

          cost = {
            input = 0.07;
            output = 0.14;
            cacheRead = 0.014;
            cacheWrite = 0;
          };

          compat = {
            supportsStore = false;
            supportsDeveloperRole = false;
            maxTokensField = "max_tokens";
            requiresReasoningContentOnAssistantMessages = true;
            thinkingFormat = "deepseek";
          };
        }

        {
          id = "deepseek-v4-pro";
          name = "Deepseek V4 Pro";
          reasoning = true;
          input = [ "text" ];
          contextWindow = 1048576;
          maxTokens = 384000;

          thinkingLevelMap = {
            minimal = null;
            low = "low";
            medium = null;
            high = "high";
            max = "max";
          };

          # DeepSeek official pricing (peak/standard), USD per 1M tokens:
          # input (cache miss) 1.32, cache hit 0.044, output 3.96.
          # DeepSeek caching is automatic so there is no cache-write charge.
          cost = {
            input = 1.32;
            output = 3.96;
            cacheRead = 0.044;
            cacheWrite = 0;
          };

          compat = {
            supportsStore = false;
            supportsDeveloperRole = false;
            maxTokensField = "max_tokens";
            requiresReasoningContentOnAssistantMessages = true;
            thinkingFormat = "deepseek";
          };
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

    e-flowcode-claude-free = {
      headers.User-Agent = "codex_cli_rs/0.77.0 (Windows 10.0.26100; x86_64) WindowsTerminal";
      baseUrl = "https://e-flowcode.cc/v1";
      api = "openai-completions";
      apiKey = "!cat ${config.sops.secrets.e-flowcode-claude-free-apikey.path}";

      models = [
        {
          id = "claude-opus-5";
          name = "Claude Opus 5";
          reasoning = true;
        }
      ];
    };

    e-flowcode-claude-vip = {
      headers.User-Agent = "codex_cli_rs/0.77.0 (Windows 10.0.26100; x86_64) WindowsTerminal";
      baseUrl = "https://e-flowcode.cc/v1";
      api = "openai-completions";
      apiKey = "!cat ${config.sops.secrets.e-flowcode-claude-vip-apikey.path}";

      models = [
        {
          id = "claude-opus-5";
          name = "Claude Opus 5";
          reasoning = true;
        }

        {
          id = "claude-fable-5-1";
          name = "Claude Fable 5.1";
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

        # 强制 z-ai/glm-5.3-flash 走 baseten 的 fp8 路由
        "z-ai/glm-5.3-flash".compat.openRouterRouting = {
          only = [
            "baseten"
          ];
          quantizations = [
            "fp8"
          ];
          allow_fallbacks = false;
        };

        # 强制 openai/gpt-oss-120b 走 cerebras 的 fp16 路由
        "openai/gpt-oss-120b".compat.openRouterRouting = {
          only = [
            "cerebras"
          ];
          quantizations = [
            "fp16"
          ];
          allow_fallbacks = false;
        };
      };
    };
  };

  sops.secrets = {
    e-flowcode-gpt-apikey = { };
    e-flowcode-cn-apikey = { };
    e-flowcode-gemini-apikey = { };
    e-flowcode-claude-free-apikey = { };
    e-flowcode-claude-vip-apikey = { };
    deepseek-apikey = { };
    openrouter-apikey = { };
  };
}
