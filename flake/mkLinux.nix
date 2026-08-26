inputs:
let
  system = "x86_64-linux";

  pkgs-master = import inputs.nixpkgsMaster {
    inherit system;
    config.allowUnfree = true;
  };

  settings = import ../settings;

  mkHome = import ./mkHome.nix inputs;
in
{
  hostname,
  hardware-module ? null,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = { inherit hostname settings pkgs-master; };

  modules = [
    ../hosts/${hostname}

    ../linux/os.nix

    ../shared

    inputs.homeManager.nixosModules.home-manager
    {
      homeManager = {
        extraSpecialArgs = {
          inherit
            hostname
            settings
            pkgs-master
            ;

          firefoxAddons = inputs.firefoxAddons;
        };

        useGlobalPkgs = true;
        useUserPackages = true;

        backupFileExtension = "bak";
        overwriteBackup = true;

        users.${settings.user.name} = mkHome {
          inherit settings;

          homeDirectory = "/home/${settings.user.name}";

          extraImports = [ ../linux/home.nix ];
        };
      };
    }

    inputs.stylix.nixosModules.stylix
    {
      stylix.homeManagerIntegration.autoImport = false;
    }
    inputs.disko.nixosModules.disko
    inputs.sopsNix.nixosModules.sops

    {
      networking.hostName = hostname;
    }
  ]
  ++ (if hardware-module != null then [ hardware-module ] else [ ]);
}
