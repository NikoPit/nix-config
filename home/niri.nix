{
  programs.niri.settings = {
    binds = {
      "Mod+Q".action.spawn = "ghostty";
      "Mod+Space".action.spawn-sh = "wofi --show drun";

      "Mod+O".action.toggle-overview;
      "Mod+C".action.close-window;

      "Mod+H".action.focus-column-left;
      "Mod+L".action.focus-column-right;
      "Mod+K".action.focus-column-up;
      "Mod+J".action.focus-column-down;
    };

    output."DP-3" = {
      mode = "2560x1440@240";
    };

    spawn-at-startup = [
      "waybar"
    ];
  };
}
