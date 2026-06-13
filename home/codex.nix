{
  programs.codex = {
    enable = true;
    settings = {
      model_provider = "e-flowcode";
      model_providers.e-flowcode = {
        name = "e-flowcode";
        base_url = "https://e-flowcode.cc/v1";
        wire_api = "responces";
        requires_openai_auth = true;
      };
    };
  };
}
