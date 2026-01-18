{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    niri.url = "github:sodiboo/niri-flake";
    nixcord.url = "github:kaylorben/nixcord";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nix-citizen.inputs.nix-gaming.follows = "nix-gaming";
  };

  outputs = { nixpkgs, home-manager, nixvim, niri, nixcord, nixos-hardware, nix-citizen, ... }: let
    makeSystem = { hostname, display, hardware-module ? null }: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit hostname display; };

      modules = [ 
        ./hosts/${hostname}/config.nix
  
        home-manager.nixosModules.home-manager {
	  home-manager.extraSpecialArgs = { inherit hostname display; };

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.elysia = import ./home/configuration-home.nix;

	  home-manager.sharedModules = [ nixcord.homeModules.nixcord ];
        }

        nixvim.nixosModules.nixvim
	niri.nixosModules.niri
	nix-citizen.nixosModules.default
      ] ++ (if hardware-module != null then [hardware-module] else []);
    };

  in {
    # System configuration   
    nixosConfigurations.elysiapc = makeSystem { hostname = "elysiapc"; display = "DP-3"; };
    nixosConfigurations.surface = makeSystem { hostname = "surface"; display = "eDP-1"; };
  };  
}
