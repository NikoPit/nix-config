{ config, pkgs, ... }:

{
  sops.age.keyFile = "${config.home.homeDirectory}/.key.txt";

  home.packages = [ pkgs.sops ];
}
