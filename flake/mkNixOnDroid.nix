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
  home-manager-path = inputs.homeManager.outPath;

  modules = [
    ../hosts/nix-on-droid/${deviceName}/system.nix

    {
      user.userName = settings.user.name;

      home-manager = {
        useGlobalPkgs = true;

        config = mkHome {
          # Let nix-on-droid set the username and homeDirectory
          username = null;
          homeDirectory = null;

          extraImports = [ ../hosts/nix-on-droid/${deviceName}/home.nix ];
        };
      };
    }
  ];
}
