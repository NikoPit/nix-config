{
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      model = "e-flowcode/gpt-5";

      provider.e-flowcode = {
        npm = "@ai-sdk/openai";
        name = "e-flowcode";
        options = {
          baseURL = "https://e-flowcode.cc/v1";
          apiKey = "{env:OPENAI_API_KEY}";
        };
        models.gpt-5 = {
          name = "GPT-5";
        };
      };
    };
  };
}
