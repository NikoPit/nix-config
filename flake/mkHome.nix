inputs:
{
  username,
  homeDirectory,
  extraImports,
}:
let
  settings = import ../settings;
  lib = inputs.nixpkgs.lib;
in
{
  home =
    { stateVersion = "25.05"; }
    // lib.optionalAttrs (username != null) { inherit username; }
    // lib.optionalAttrs (homeDirectory != null) { inherit homeDirectory; };

  imports = [
    ../lib/keybinds.nix

    inputs.sopsNix.homeManagerModules.sops
    inputs.nixcraft.homeModules.default
    inputs.nixvim.homeModules.nixvim
    inputs.stylix.homeModules.stylix

    ../shared
    ../generic
  ]
  ++ extraImports;
}
