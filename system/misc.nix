{ settings, ... }:
{
  system.stateVersion = "25.05";
  services.getty.autologinUser = settings.user.name;
  security.sudo.wheelNeedsPassword = false;
  programs.command-not-found.enable = false;
  documentation.man.enable = false;
  # Enable wayland for electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nix.settings = {
    substituters = [ "https://nix-community.cachix.org" ];
    trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };
}
