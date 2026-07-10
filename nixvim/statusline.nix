{ lib, ... }:

let
  empty = lib.nixvim.mkRaw "{}";
in
{
  plugins.lualine = {
    enable = true;

    settings = {
      options = {
        component_separators = {
          left = "";
          right = "";
        };

        section_separators = {
          left = "";
          right = "";
        };
      };

      sections = lib.mkForce {
        lualine_a = [ "mode" ];
        lualine_b = empty;
        lualine_c = empty;
        lualine_x = empty;
        lualine_y = empty;
        lualine_z = [ "diagnostics" ];
      };

      inactive_sections = empty;
    };
  };
}
