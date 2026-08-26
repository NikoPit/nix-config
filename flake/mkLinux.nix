inputs:
let
  settings = import ../settings;

  mkHome = import ./mkHome.nix inputs;
in
{
  hostname,
  hardware-module ? null,
}:
inputs.nixpkgs.lib.nixosSystem {
  specialArgs = { inherit hostname settings; };

  modules = [
    ../hosts/linux/${hostname}

    ../linux/os.nix

    ../shared

    inputs.homeManager.nixosModules.home-manager
    {
      homeManager = {
        extraSpecialArgs = {
          inherit
            hostname
            settings
            ;

          firefoxAddons = inputs.firefoxAddons;
        };

        useGlobalPkgs = true;
        useUserPackages = true;

        backupFileExtension = "bak";
        overwriteBackup = true;

        users.${settings.user.name} = mkHome {
          username = settings.user.name;
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
