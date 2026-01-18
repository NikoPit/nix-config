{
  programs.niri.settings = {
    hotkey-overlay.skip-at-startup = true;

    window-rules = [{
      open-floating = true;
      clip-to-geometry = true;
      geometry-corner-radius = 
        let
	  r = 10.0;
	in {
	  top-right = r;
	  top-left = r;
	  bottom-left = r;
	  bottom-right = r;
	};
    }];

    layout = {
      focus-ring.enable = false;

      shadow = {
        enable = true;
	color = "#6cb0e070";
      };
    };
  };
}
