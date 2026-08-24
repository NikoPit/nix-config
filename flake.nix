{
  description = "System config";

  inputs = {
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";
    nixpkgs-master.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=master&shallow=1";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcraft = {
      url = "github:NikoPit/nixcraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-master,
      disko,
      stylix,
      home-manager,
      nixvim,
      nixos-hardware,
      sops-nix,
      firefox-addons,
      nixcraft,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs { inherit system; };
      pkgs-master = import nixpkgs-master {
        inherit system;
        config.allowUnfree = true;
      };

      settings = import ./settings { inherit pkgs; };

      makeSystem =
        {
          hostname,
          hardware-module ? null,
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit hostname settings pkgs-master; };

          modules = [
            ./hosts/${hostname}

            ./hyprland/os.nix
            ./modules/os.nix
            ./system

            ./secret/os.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                extraSpecialArgs = {
                  inherit
                    hostname
                    settings
                    firefox-addons
                    pkgs-master
                    ;
                };

                useGlobalPkgs = true;
                useUserPackages = true;

                backupFileExtension = "bak";
                overwriteBackup = true;

                users.${settings.user.name} = {
                  imports = [
                    sops-nix.homeManagerModules.sops
                    nixcraft.homeModules.default
                    nixvim.homeManagerModules.nixvim

                    ./nixvim
                    ./hyprland/home.nix
                    ./modules/home.nix
                    ./music
                    ./minecraft
                    ./agent

                    ./secret/home.nix
                  ];
                };
              };
            }

            stylix.nixosModules.stylix
            disko.nixosModules.disko
            sops-nix.nixosModules.sops

            {
              networking.hostName = hostname;
            }
          ]
          ++ (if hardware-module != null then [ hardware-module ] else [ ]);
        };

    in
    {
      # System configuration
      nixosConfigurations.elysiapc = makeSystem {
        hostname = "elysiapc";
      };
      nixosConfigurations.surface = makeSystem {
        hostname = "surface";
      };
    };
}
