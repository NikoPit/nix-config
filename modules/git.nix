{ settings, config, ... }:

let
  makeCredHelper =
    { username, password }:
    "!f() { echo username=${username}; echo password=${password}; }; f";

  githubUsername = settings.user.githubName;
  githubToken = "$(cat ${config.sops.secrets.github-token.path})";

  githubCredHelper = makeCredHelper {
    username = githubUsername;
    password = githubToken;
  };
in
{
  sops.secrets.github-token.mode = "0400";

  programs.git = {
    enable = true;

    settings = {
      user = settings.user;

      credential."https://github.com".helper = githubCredHelper;
    };
  };
}
