{ pkgs, ... }:

{
  programs.niri.settings = {

    hotkey-overlay.skip-at-startup = true;

    layer-rules = [
      {
        matches = [ { namespace = "^wallpaper$"; } { namespace = "^waybar$"; } ];
        place-within-backdrop = true;
      }
      ];

    binds = {
      "Mod+Q".action.spawn = "ghostty";
      "Mod+Space".action.spawn-sh = "rofi -show drun";

      "Mod+O".action.toggle-overview = [];
      "Mod+C".action.close-window = [];

      "Mod+Left".action.focus-column-left = [];
      "Mod+Right".action.focus-column-right = [];
      "Mod+Up".action.focus-window-or-workspace-up = [];
      "Mod+Down".action.focus-window-or-workspace-down = [];
      "Mod+H".action.focus-column-left = [];
      "Mod+L".action.focus-column-right = [];
      "Mod+K".action.focus-window-or-workspace-up = [];
      "Mod+J".action.focus-window-or-workspace-down = [];

      "Mod+Ctrl+Left".action.move-column-left = [];
      "Mod+Ctrl+Right".action.move-column-right = [];
      "Mod+Ctrl+Up".action.move-window-up-or-to-workspace-up = [];
      "Mod+Ctrl+Down".action.move-window-down-or-to-workspace-down = [];
      "Mod+Ctrl+H".action.move-column-left = [];
      "Mod+Ctrl+L".action.move-column-right = [];
      "Mod+Ctrl+K".action.move-window-up-or-to-workspace-up = [];
      "Mod+Ctrl+J".action.move-window-down-or-to-workspace-down = [];

      "Mod+WheelScrollUp".action.focus-workspace-up = [];
      "Mod+WheelScrollDown".action.focus-workspace-down = [];

      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+6".action.focus-workspace = 6;
      "Mod+7".action.focus-workspace = 7;
      "Mod+8".action.focus-workspace = 8;
      "Mod+9".action.focus-workspace = 9;
      "Mod+Ctrl+1".action.move-column-to-workspace = 1;
      "Mod+Ctrl+2".action.move-column-to-workspace = 2;
      "Mod+Ctrl+3".action.move-column-to-workspace = 3;
      "Mod+Ctrl+4".action.move-column-to-workspace = 4;
      "Mod+Ctrl+5".action.move-column-to-workspace = 5;
      "Mod+Ctrl+6".action.move-column-to-workspace = 6;
      "Mod+Ctrl+7".action.move-column-to-workspace = 7;
      "Mod+Ctrl+8".action.move-column-to-workspace = 8;
      "Mod+Ctrl+9".action.move-column-to-workspace = 9;

      "F11".action.fullscreen-window = [];

      "Mod+F".action.maximize-column = [];
      "Mod+Ctrl+F".action.expand-column-to-available-width = [];

      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";

      "Mod+V".action.toggle-window-floating = [];

      "Mod+Shift+Slash".action.show-hotkey-overlay = [];

      "Print".action.screenshot = [];
    };

    outputs."DP-3" = {
      mode.width = 2560;
      mode.height = 1440;
      mode.refresh = 180.0;
    };

    spawn-at-startup = [
      # TODO: make the path to wallpaper a nix path (with ${../wallpaper} or something)
      { sh = "${pkgs.linux-wallpaperengine}/bin/linux-wallpaperengine ~/nix/wallpaper --screen-root DP-3 --silent --no-audio-processing --no-fullscreen-pause"; }
    ];
  };
}
