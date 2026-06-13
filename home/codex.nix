{
  programs.codex = {
    enable = true;
    settings = {
      model_provider = "e-flowcode";
      sandbox_mode = "danger-full-access";
      approval_policy = "never";
      model_providers.e-flowcode = {
        name = "e-flowcode";
        base_url = "https://e-flowcode.cc/v1";
        wire_api = "responses";
        requires_openai_auth = true;
      };
    };
  };
}
