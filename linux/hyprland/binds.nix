{ lib }:

let
  bind = combo: dispatcher: {
    _args = [
      combo
      (lib.generators.mkLuaInline dispatcher)
    ];
  };
in
[
  (bind "SUPER + TAB" ''hl.dsp.exec_cmd("hyprctl dispatch overview:toggle")'')

  (bind "SUPER + C" "hl.dsp.window.close()")
  (bind "SUPER + V" ''hl.dsp.window.float({ action = "toggle" })'')

  (bind "SUPER + equal" "hl.dsp.window.resize({ x = 100, y = 0, relative = true })")
  (bind "SUPER + minus" "hl.dsp.window.resize({ x = -100, y = 0, relative = true })")

  (bind "SUPER + ALT + H" ''hl.dsp.window.move({ direction = "left" })'')
  (bind "SUPER + ALT + L" ''hl.dsp.window.move({ direction = "right" })'')
  (bind "SUPER + ALT + K" ''hl.dsp.window.move({ workspace = "-1" })'')
  (bind "SUPER + ALT + J" ''hl.dsp.window.move({ workspace = "+1" })'')

  (bind "SUPER + H" ''hl.dsp.focus({ direction = "left" })'')
  (bind "SUPER + L" ''hl.dsp.focus({ direction = "right" })'')
  (bind "SUPER + K" ''hl.dsp.focus({ direction = "up" })'')
  (bind "SUPER + J" ''hl.dsp.focus({ direction = "down" })'')

  (bind "SUPER + 1" "hl.dsp.focus({ workspace = 1 })")
  (bind "SUPER + 2" "hl.dsp.focus({ workspace = 2 })")
  (bind "SUPER + 3" "hl.dsp.focus({ workspace = 3 })")
  (bind "SUPER + 4" "hl.dsp.focus({ workspace = 4 })")
  (bind "SUPER + 5" "hl.dsp.focus({ workspace = 5 })")
  (bind "SUPER + 6" "hl.dsp.focus({ workspace = 6 })")
  (bind "SUPER + 7" "hl.dsp.focus({ workspace = 7 })")
  (bind "SUPER + 8" "hl.dsp.focus({ workspace = 8 })")
  (bind "SUPER + 9" "hl.dsp.focus({ workspace = 9 })")
]
