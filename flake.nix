{
  description = "System config";

  inputs = {
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";

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
  };

  outputs =
    {
      nixpkgs,
      disko,
      stylix,
      home-manager,
      nixvim,
      nixos-hardware,
      sops-nix,
      firefox-addons,
      ...
    }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      settings = import ./settings { inherit pkgs; };
      makeSystem =
        {
          hostname,
          hardware-module ? null,
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit hostname settings; };

          modules = [
            ./hosts/${hostname}

            ./hyprland/os.nix
            ./modules/os.nix
            ./nixvim
            ./system

            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit hostname settings firefox-addons; };

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.${settings.user.name} = {
                imports = [
                  sops-nix.homeManagerModules.sops

                  ./hyprland/home.nix
                  ./modules/home.nix
                  ./music

                  ./system/secret.nix
                ];
              };
            }

            nixvim.nixosModules.nixvim
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
