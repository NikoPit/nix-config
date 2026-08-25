{ config, lib, ... }:

let
  keyToHyprland = k:
    if k == "PRINT" then "Print"
    else k;

  toHyprland = b:
    let
      mods = lib.concatStringsSep ", " b.combo.mods;
      key = keyToHyprland b.combo.key;
    in "${mods}, ${key}, exec, ${b.action.exec}";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    settings = {
      bind = (import ./binds.nix) ++ (map toHyprland config.keybinds);

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
