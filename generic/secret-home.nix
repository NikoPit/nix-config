{ config, ... }:

{
  sops.age.keyFile = "${config.home.homeDirectory}/.key.txt";
}
