inputs: deviceName:
let
  settings = import ../settings;

  mkHome = import ./mkHome.nix inputs;

  system = "aarch64-linux";
  pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [ inputs.nixOnDroid.overlays.default ];
  };
in
inputs.nixOnDroid.lib.nixOnDroidConfiguration {
  inherit pkgs;
  extraSpecialArgs = { inherit deviceName settings; };
  home-manager-path = inputs.homeManager.outPath;

  modules = [
    inputs.stylix.nixOnDroidModules.stylix
    { stylix.homeManagerIntegration.autoImport = false; }

    ../nix-on-droid/system.nix
    ../hosts/nix-on-droid/${deviceName}/system.nix

    {
      system.stateVersion = "24.05";
      user.userName = settings.user.name;

      home-manager = {
        useGlobalPkgs = true;

        sharedModules = [
          { stylix.overlays.enable = false; }
        ];

        extraSpecialArgs = { inherit deviceName settings; };

        config = mkHome {
          # Let nix-on-droid set the username and homeDirectory
          username = null;
          homeDirectory = null;

          extraImports = [
            ../nix-on-droid/home.nix
            ../hosts/nix-on-droid/${deviceName}/home.nix
          ];
        };
      };
    }
  ];
}
