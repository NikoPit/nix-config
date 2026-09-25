{ config, ... }:

let
  userAgent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36";

  e-flowcode-gpt-models = [
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

    {
      # metadata from pi.dev's openai-codex catalog (gpt-6-sol):
      # 272K context / 128K max output, text+image input,
      # reasoning efforts none/low/medium/high/xhigh/max.
      id = "gpt-6-sol";
      name = "GPT-6 Sol";
      reasoning = true;
      input = [
        "text"
        "image"
      ];
      contextWindow = 272000;
      maxTokens = 128000;

      thinkingLevelMap = {
        off = "none";
        minimal = "low";
        low = "low";
        medium = "medium";
        high = "high";
        xhigh = "xhigh";
        max = "max";
      };

      # pi.dev openai-codex pricing (USD per 1M tokens):
      # <=272K: input 2, cacheRead 0.2, cacheWrite 2.5, output 10
      #  >272K: input 4, cacheRead 0.4, cacheWrite 5,   output 15
      cost = {
        input = 2;
        output = 10;
        cacheRead = 0.2;
        cacheWrite = 2.5;
        tiers = [
          {
            inputTokensAbove = 272000;
            input = 4;
            output = 15;
            cacheRead = 0.4;
            cacheWrite = 5;
          }
        ];
      };
    }
  ];
in
{
  programs.pi-coding-agent.models.providers = {
    e-flowcode-grok = {
      headers.User-Agent = userAgent;
      baseUrl = "https://e-flowcode.cc/v1";
      api = "openai-completions";
      apiKey = "!cat ${config.sops.secrets.e-flowcode-grok-apikey.path}";

      models = [
        {
          id = "grok-4.7";
          name = "Grok 4.7";
          reasoning = true;
          input = [
            "text"
            "image"
          ];
          contextWindow = 500000;
          maxTokens = 500000;

          thinkingLevelMap = {
            off = null;
            minimal = null;
            low = "low";
            medium = "medium";
            high = "high";
            xhigh = "xhigh";
            max = null;
          };

          cost = {
            input = 2;
            output = 6;
            cacheRead = 0.5;
            cacheWrite = 0;
            tiers = [
              {
                inputTokensAbove = 200000;
                input = 4;
                output = 12;
                cacheRead = 1;
                cacheWrite = 0;
              }
            ];
          };

          compat = {
            supportsLongCacheRetention = false;
          };
        }
      ];
    };

    e-flowcode-gpt = {
      headers.User-Agent = userAgent;
      baseUrl = "https://e-flowcode.cc/v1";
      api = "openai-responses";
      apiKey = "!cat ${config.sops.secrets.e-flowcode-gpt-apikey.path}";

      models = e-flowcode-gpt-models;
    };

    e-flowcode-gpt-smart = {
      headers.User-Agent = userAgent;
      baseUrl = "https://e-flowcode.cc/v1";
      api = "openai-responses";
      apiKey = "!cat ${config.sops.secrets.e-flowcode-gpt-smart-apikey.path}";

      models = e-flowcode-gpt-models;
    };

    e-flowcode-gpt-vip = {
      headers.User-Agent = userAgent;
      baseUrl = "https://e-flowcode.cc/v1";
      api = "openai-responses";
      apiKey = "!cat ${config.sops.secrets.e-flowcode-gpt-vip-apikey.path}";

      models = e-flowcode-gpt-models;
    };

    e-flowcode-cn = {
      headers.User-Agent = userAgent;
      baseUrl = "https://e-flowcode.cc";
      api = "anthropic-messages";
      apiKey = "!cat ${config.sops.secrets.e-flowcode-cn-apikey.path}";

      models = [
        {
          id = "glm-5.2";
          name = "GLM-5.2";
          reasoning = true;
        }

        {
          # metadata from pi's fetched openrouter data (z-ai/glm-5.3):
          # 1M context, 256K max output, text-only input, reasoning efforts low/high/max
          # (always on, cannot be disabled), USD per 1M tokens.
          #
          # maxTokens must stay at the upstream 128K: the anthropic-messages
          # adapter asks for model.maxTokens + thinkingBudget, and the relay
          # rejects anything above 128K (400 请求参数错误).
          id = "glm-5.3";
          name = "GLM-5.3";
          reasoning = true;

          thinkingLevelMap = {
            off = null;
            minimal = null;
            low = "low";
            medium = null;
            high = "high";
            xhigh = null;
            max = "max";
          };

          # 1M context / 128K max output per docs.z.ai/guides/llm/glm-5.3
          contextWindow = 1048576;
          maxTokens = 131072;

          cost = {
            input = 1.4;
            output = 4.4;
            cacheRead = 0.14;
            cacheWrite = 0;
          };
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
          # metadata copied from the built-in `deepseek` provider's `deepseek-flash`:
          # 1M context, 384K max output, text+image input, USD per 1M tokens
          id = "deepseek-v4.1-flash";
          name = "DeepSeek V4.1 Flash";
          reasoning = true;
          input = [
            "text"
            "image"
          ];
          contextWindow = 1000000;
          maxTokens = 384000;

          thinkingLevelMap = {
            minimal = null;
            low = "low";
            medium = null;
            high = "high";
            max = "max";
          };

          cost = {
            input = 0.3;
            output = 1.2;
            cacheRead = 0.006;
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
      headers.User-Agent = userAgent;
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
      headers.User-Agent = userAgent;
      baseUrl = "https://e-flowcode.cc/v1";
      api = "anthropic-messages";
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
      headers.User-Agent = userAgent;
      baseUrl = "https://e-flowcode.cc/v1";
      api = "anthropic-messages";
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
    e-flowcode-grok-apikey = { };
    e-flowcode-gpt-apikey = { };
    e-flowcode-gpt-vip-apikey = { };
    e-flowcode-gpt-smart-apikey = { };
    e-flowcode-cn-apikey = { };
    e-flowcode-gemini-apikey = { };
    e-flowcode-claude-free-apikey = { };
    e-flowcode-claude-vip-apikey = { };
    deepseek-apikey = { };
    openrouter-apikey = { };
  };
}
