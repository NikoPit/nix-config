{
  programs.ghostty = {
    enable = true;

    settings = {
    	window-decoration = "none";
    };
  };

  home.sessionVariables."TERM" = "ghostty";
}
