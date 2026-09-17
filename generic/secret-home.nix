{ config, pkgs, ... }:

let
  sopsKeyFile = "${config.home.homeDirectory}/.key.txt";
in
{
  sops.age.keyFile = sopsKeyFile;
  home.packages = [ pkgs.sops ];

  programs.fish.shellAliases.sops = "SOPS_AGE_KEY_FILE=${sopsKeyFile} sops";

}
