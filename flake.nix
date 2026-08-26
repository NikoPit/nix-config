{
  description = "System config";

  inputs = {
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
    nixpkgsMaster.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=master&shallow=1";

    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    nixosHardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sopsNix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefoxAddons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcraft = {
      url = "github:NikoPit/nixcraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs { inherit system; };
      pkgs-master = import inputs.nixpkgsMaster {
        inherit system;
        config.allowUnfree = true;
      };

      settings = import ./settings { inherit pkgs; };

      mkHome =
        {
          settings,
          homeDirectory,
          extraImports,
        }:
        {
          home = {
            username = settings.user.name;
            inherit homeDirectory;
            stateVersion = "25.05";
          };

          imports = [
            ./lib/keybinds.nix

            inputs.sopsNix.homeManagerModules.sops
            inputs.nixcraft.homeModules.default
            inputs.nixvim.homeModules.nixvim
            inputs.stylix.homeModules.stylix

            ./shared
            ./generic
          ]
          ++ extraImports;
        };

      mkLinux =
        {
          hostname,
          hardware-module ? null,
        }:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = { inherit hostname settings pkgs-master; };

          modules = [
            ./hosts/${hostname}

            ./linux/os.nix

            ./shared

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

                  extraImports = [ ./linux/home.nix ];
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
        };
    in
    {
      nixosConfigurations.elysiapc = mkLinux {
        hostname = "elysiapc";
      };
      nixosConfigurations.surface = mkLinux {
        hostname = "surface";
      };
    };
}
