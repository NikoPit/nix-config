{ settings, ... }:

{
  system = {
    stateVersion = 6;
    primaryUser = settings.user.name;
  };

  users = {
    knownUsers = [ settings.user.name ];

    users.${settings.user.name} = {
      home = "/Users/${settings.user.name}";
    };
  };

  imports = [
    ./shell.nix
    ./nix.nix
  ];

  nixpkgs.config.allowUnfree = true;
}
