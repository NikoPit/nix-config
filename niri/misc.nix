{
  programs.niri.settings = {
    hotkey-overlay.skip-at-startup = true;
    layout.focus-ring.enable = false;

    window-rules = [{
      matches = [{ app-id = ".*"; }];
      open-floating = true;
    }];
  };
}
