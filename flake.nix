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
  };

  outputs = { nixpkgs, home-manager, nixvim, niri, nixcord, ... }: {
    # System configuration   
    nixosConfigurations.elysiapc = nixpkgs.lib.nixosSystem {
      modules = [ 
        ./hosts/elysiapc/config.nix
  
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.elysia = import ./home/configuration-home.nix;

	  home-manager.sharedModules = [ nixcord.homeModules.nixcord ];
        }

        nixvim.nixosModules.nixvim

	niri.nixosModules.niri
      ];
    };
  };
}
