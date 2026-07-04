{
  services.dunst = {
    enable = true;

    settings.global = {
      origin = "bottom-right";
      progress_bar = true;
      icon_corner_radius = 10;
      corner_radius = 10;
      offset = "(0, 100)";
      width = "(200, 400)";
      gap_size = 10;
      corners = "left";
      frame_width = 0;
    };
  };
}
