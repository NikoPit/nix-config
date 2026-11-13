{ lib, ... }:

{
  options.shellHooks = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "Commands to run when a shell starts.";
  };
}
