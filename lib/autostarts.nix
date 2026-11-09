{ lib, ... }:

{
  options.autostarts = lib.mkOption {
    type = lib.types.listOf (
      lib.types.submodule {
        options = {
          command = lib.mkOption {
            type = lib.types.str;
            description = "Command to run when Hyprland starts.";
          };

          workspace = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "Workspace to place the launched window on.";
          };
        };
      }
    );

    default = [ ];
    description = "Commands to launch when Hyprland starts.";
  };
}
