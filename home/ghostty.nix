{
  programs.ghostty = {
    enable = true;

    settings = {
    	window-decoration = "none";
    };
  };

  programs.niri.settings.environment.TERM = "ghostty";
}
