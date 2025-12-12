{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim/nixos-25.05";
  };

  outputs = { nixpkgs, home-manager, nixvim, ... }: {
    # System configuration   
    nixosConfigurations.elysiapc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./os/configuration.nix 
  
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.elysia = import ./home/configuration-home.nix;
        }

        nixvim.nixosModules.nixvim
      ];
    };
  };
}
