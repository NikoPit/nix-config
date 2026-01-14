{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim/nixos-25.05";
    niri.url = "github:sodiboo/niri-flake";
    nixcord.url = "github:kaylorben/nixcord";
    nix-citizen.url = "github:LovingMelody/nix-citizen";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = { nixpkgs, home-manager, nixvim, niri, nixcord, nix-citizen, nix-flatpak, ... }: {
    # System configuration   
    nixosConfigurations.elysiapc = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit nix-citizen;};

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

	nix-flatpak.nixosModules.nix-flatpak
      ];
    };
  };
}
