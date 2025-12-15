{
  programs.waybar = {
    enable = true;

    settings = {};
  };
  
  programs.niri.settings.spawn-at-startup = [
    { sh = "waybar"; }
  ];
}
