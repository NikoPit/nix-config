{ config, ... }:

let
  cacheName = "roxy";
in
{
  nix.settings = {
    substituters = [ "https://${cacheName}.cachix.org" ];

    trusted-public-keys = [ "roxy.cachix.org-1:gj2jWTAp/0EugTY4Qlss7pqM1+035Yh5CIFPZkf33I0=" ];
  };

  sops.secrets.cachix-token = {
    owner = "root";
    group = "root";
    mode = "0400";
  };

  services.cachix-watch-store = {
    enable = true;
    inherit cacheName;
    cachixTokenFile = config.sops.secrets.cachix-token.path;
  };
}
