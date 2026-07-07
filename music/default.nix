{ pkgs, ... }:

let
  tracks = import ./tracks.nix { inherit pkgs; };
in
{
  services.mpd = {
    enable = true;

    musicDirectory = "${tracks}";
  };

  services.mpdris2-rs.enable = true;

  home.packages = [ pkgs.mpc ];
}
