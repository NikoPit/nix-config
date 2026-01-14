{
  programs.niri.settings.layer-rules = [
      {
        matches = [ { namespace = "^wallpaper$"; } { namespace = "^waybar$"; } ];
        place-within-backdrop = true;
      }
  ];
}
