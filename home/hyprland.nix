{
  wayland.windowManager.hyprland = {
    #enable = true;

    settings = {
      "$mod" = "SUPER";    

      monitor = ",2560x1440@240,auto,1";

      bind = [
        "$mod, Q, exec, ghostty"
      ]; 
    };
  };
}
