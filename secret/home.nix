{ settings, ... }:

{
  imports = [ ./common.nix ];

  sops.age.keyFile = "/home/${settings.user.name}/.key.txt";
}
