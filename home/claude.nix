{
  programs.claude-code = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      env = {
        ANTHROPIC_BASE_URL = "https://e-flowcode.cc";
      };
      permissions = {
        defaultMode = "bypassPermissions";
        disableBypassPermissionsMode = "disable";
      };
      statusLine = {
        type = "command";
        command = "bash /home/elysia/.claude/statusline-command.sh";
      };
      theme = "auto";
    };
  };
}
