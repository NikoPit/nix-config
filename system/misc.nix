{ settings, ... }:
{
  system.stateVersion = "25.05";
  services.getty.autologinUser = settings.user.name;
  security.sudo.wheelNeedsPassword = false;
  programs.command-not-found.enable = false;
}
