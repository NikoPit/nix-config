{ lib, ... }:

{
  options.keybinds = lib.mkOption {
    type = lib.types.listOf (lib.types.submodule {
      options = {
        combo = lib.mkOption {
          type = lib.types.submodule {
            options = {
              mods = lib.mkOption {
                type = lib.types.listOf (lib.types.enum [ "SUPER" "CTRL" "ALT" "SHIFT" ]);
                default = [ ];
              };

              key = lib.mkOption {
                type = lib.types.enum [
                  "Q" "W" "E" "R" "T" "Y" "U" "I" "O" "P"
                  "A" "S" "D" "F" "G" "H" "J" "K" "L"
                  "Z" "X" "C" "V" "B" "N" "M"
                  "1" "2" "3" "4" "5" "6" "7" "8" "9" "0"
                  "F1" "F2" "F3" "F4" "F5" "F6" "F7" "F8" "F9" "F10" "F11" "F12"
                  "UP" "DOWN" "LEFT" "RIGHT"
                  "HOME" "END" "PAGE_UP" "PAGE_DOWN" "INSERT" "DELETE"
                  "BACKSPACE" "TAB" "ENTER" "ESC"
                  "SPACE" "PRINT"
                ];
              };
            };
          };
        };

        action = lib.mkOption {
          type = lib.types.submodule {
            options = {
              exec = lib.mkOption {
                type = lib.types.str;
              };
            };
          };
        };
      };
    });
    default = [ ];
  };
}
