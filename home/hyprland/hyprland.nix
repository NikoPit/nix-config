# ABANDONED DONT USE

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      imports = [
        "./monitors.nix"
	"./programas.nix"
	"./autostart.nix"
	"./binds.nix"
      ]

      decoration = {
        shadow_offset = "0 5";
        "col.shadow" = "rgba(00000099)";
      };

      "$mod" = "SUPER";

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
    };
  };
}
