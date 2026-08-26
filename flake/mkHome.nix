inputs: { homeDirectory, extraImports }:
let
  settings = import ../settings;
in
{
  home = {
    username = settings.user.name;
    inherit homeDirectory;
    stateVersion = "25.05";
  };

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
