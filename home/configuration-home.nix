{  config, pkgs, ... }: {
  home = {
    username = "elysia";
    homeDirectory = "/home/elysia";
    stateVersion = "25.05";
  };

  imports = [
    ./bundle.nix
  ];
}
