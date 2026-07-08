{ pkgs, ... }:

let
  tracksDir = import ./tracks.nix { inherit pkgs; };
in
{
  services.mpd = {
    enable = true;

    musicDirectory = "${tracksDir}";
  };

  services.mpdris2-rs.enable = true;

  home.packages = [ pkgs.mpc ];

  imports = [
    ./effect.nix
  ];
}
