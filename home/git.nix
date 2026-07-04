{ settings, ... }:
{
  programs.git = {
    enable = true;

    settings.user = settings.user;
  };
}
