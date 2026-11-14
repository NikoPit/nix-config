{
  config,
  lib,
  pkgs,
  ...
}:

let
  keyToHyprland = k: if k == "PRINT" then "Print" else k;

  toLuaBind = b: {
    _args = [
      (lib.concatStringsSep " + " (b.combo.mods ++ [ (keyToHyprland b.combo.key) ]))
      (lib.generators.mkLuaInline "hl.dsp.exec_cmd(${lib.generators.toLua { } b.action.exec})")
    ];
  };

  toLuaAutostart =
    a:
    if a.workspace == null then
      "hl.exec_cmd(${lib.generators.toLua { } a.command})"
    else
      "hl.exec_cmd(${lib.generators.toLua { } a.command}, { workspace = ${
        lib.generators.toLua { } a.workspace
      } })";
in
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";

    settings = {
      bind =
        (import ./binds.nix { inherit lib; })
        ++ (map toLuaBind config.keybinds)
        ++ [
          {
            _args = [
              "SUPER + mouse:272"
              (lib.generators.mkLuaInline "hl.dsp.window.drag()")
              { mouse = true; }
            ];
          }
          {
            _args = [
              "SUPER + mouse:273"
              (lib.generators.mkLuaInline "hl.dsp.window.resize()")
              { mouse = true; }
            ];
          }
        ];

      animation = import ./animation.nix;

      config = {
        decoration = import ./decoration.nix;
        general = import ./general.nix;
        input.kb_options = "caps:escape";
      };

      monitor = {
        output = "";
        mode = "highrr";
        position = "auto";
        scale = 1;
      };

      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              ${lib.concatMapStringsSep "\n" toLuaAutostart config.autostarts}
            end
          '')
        ];
      };
    };
  };
}
