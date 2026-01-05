{
  programs.waybar = {
    enable = true;

    settings.main = {
      height = 40;
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
  
  programs.niri.settings.spawn-at-startup = [
    { sh = "waybar"; }
  ];
}
