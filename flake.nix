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

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      disko,
      home-manager,
      nixvim,
      niri,
      nixos-hardware,
      ...
    }:
    let
      settings = import ./settings;
      makeSystem =
        {
          hostname,
          display,
          hardware-module ? null,
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit hostname display settings; };

          modules = [
            ./hosts/${hostname}/config.nix
            ./system/bundle.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit hostname display; };

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.elysia = import ./home/configuration-home.nix;
            }

            nixvim.nixosModules.nixvim
            disko.nixosModules.disko
            niri.nixosModules.niri
          ]
          ++ (if hardware-module != null then [ hardware-module ] else [ ]);
        };

    in
    {
      # System configuration
      nixosConfigurations.elysiapc = makeSystem {
        hostname = "elysiapc";
        display = "DP-3";
      };
      nixosConfigurations.surface = makeSystem {
        hostname = "surface";
        display = "eDP-1";
      };
    };
}
