{ pkgs, ... }:

{
  user.shell = "${pkgs.fish}/bin/fish";
}
