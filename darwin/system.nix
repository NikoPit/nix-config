{ settings, ... }:

{
  system = {
    stateVersion = 6;
    primaryUser = settings.user.name;
  };

  users.users.${settings.user.name}.home = "/Users/${settings.user.name}";
}
