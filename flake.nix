{
  description = "System config";

  inputs = {
    nixpkgs.url = "git+https://mirrors.nju.edu.cn/git/nixpkgs.git?ref=nixos-unstable&shallow=1";

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

    nixOnDroid = {
      url = "github:nix-community/nix-on-droid";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "homeManager";
    };
  };

  outputs = { ... }@inputs:
    let
      mkLinux = import ./flake/mkLinux.nix inputs;
      mkNixOnDroid = import ./flake/mkNixOnDroid.nix inputs;
    in
    {
      nixosConfigurations.elysiapc = mkLinux {
        hostname = "elysiapc";
      };
      nixosConfigurations.surface = mkLinux {
        hostname = "surface";
      };

      nixOnDroidConfigurations.default = mkNixOnDroid;
    };
}
