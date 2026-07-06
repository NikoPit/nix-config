{ pkgs, ... }:

{
  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;

    package = pkgs.hyprland;

    settings = {
      bind = import ./binds.nix;

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      monitor = [ ",highrr,auto,1" ];
    };
  };

  _module.args.greetdSession = "uwsm start hyprland";
}
