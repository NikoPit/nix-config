{ settings, ... }:
{
  home = {
    username = settings.user.name;
    homeDirectory = "/home/${settings.user.name}";
    stateVersion = "25.05";
  };
}
