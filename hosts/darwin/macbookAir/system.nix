{ settings, ... }:

{
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.${settings.user.name} = {
    uid = 501;
    gid = 20;
  };
}
