{
  programs.waybar = {
    enable = true;

    settings.main = {
      height = 40;

      margin-top = 10;
      margin-left = 10;
      margin-right = 10;
      margin-bottom = 0;

      spacing = 10;
      modules-left = [
        "tray"
      ];

      modules-center = [
        "niri/workspaces"
      ];

      modules-right = [
        "pulseaudio"
        "battery"
        "clock"
      ];
    };
  };
}
