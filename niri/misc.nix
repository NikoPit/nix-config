{
  programs.niri.settings = {
    hotkey-overlay.skip-at-startup = true;
    layout.focus-ring.enable = false;

    window-rules = [{
      open-floating = true;
      clip-to-geometry = true;
      geometry-corner-radius = 
        let
	  r = 20.0;
	in {
	  top-right = r;
	  top-left = r;
	  bottom-left = r;
	  bottom-right = r;
	};
    }];
  };
}
