{
  applicationLauncher,
  terminal,
  ...
}:

{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      bind = import ./binds.nix { inherit applicationLauncher terminal; };
      animation = import ./animation.nix;
      decoration = import ./decoration.nix;
      general = import ./general.nix;

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      monitor = [ ",highrr,auto,1" ];
    };
  };
}
