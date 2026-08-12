{
  model = "gpt-5.6-sol";
  model_reasoning_effort = "low";
  model_provider = "e-flowcode";

  sandbox_mode = "danger-full-access";
  approval_policy = "never";
  dangerously_bypass_hook_trust = true;
  projects."/".trust_level = "trusted";
  tui.vim_mode_default = true;

  model_providers.e-flowcode = {
    name = "e-flowcode";
    base_url = "https://e-flowcode.cc/v1";
    wire_api = "responses";
    requires_openai_auth = true;

    request_max_retries = 100;
    stream_max_retries = 100;
  };
}
