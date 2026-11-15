inputs:
let
  settings = import ../settings;

  mkHome = import ./mkHome.nix inputs;
in
hostname:
inputs.nixDarwin.lib.darwinSystem {
  specialArgs = { inherit hostname settings; };

  modules = [
    ../hosts/darwin/${hostname}/system.nix

    ../darwin/system.nix

    ../shared

    inputs.homeManager.darwinModules.home-manager
    {
      home-manager = {
        extraSpecialArgs = { inherit hostname settings; };

        useGlobalPkgs = true;
        useUserPackages = true;

        sharedModules = [
          { stylix.overlays.enable = false; }
        ];

        backupFileExtension = "bak";
        overwriteBackup = true;

        users.${settings.user.name} = mkHome {
          username = settings.user.name;
          homeDirectory = "/Users/${settings.user.name}";

          extraImports = [
            ../darwin/home.nix
            ../hosts/darwin/${hostname}/home.nix
          ];
        };
      };
    }

    inputs.stylix.darwinModules.stylix
    {
      stylix.homeManagerIntegration.autoImport = false;
    }
    inputs.sopsNix.darwinModules.sops

    {
      networking.hostName = hostname;
    }
  ];
}
