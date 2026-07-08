{ pkgs, ... }:

let
  audioFormat = "mp3";
  fetchMusic = import ./fetch-music.nix { inherit pkgs; };

  tracks = {
    "Angel Dust (2008 Mix)" = fetchMusic {
      url = "https://www.youtube.com/watch?v=jszUs6TvsI8";
      hash = "sha256-6n6SJ7ChYxwV+iWkC/+5yb4O9yEZERecWTeM7RhCsS8=";
      inherit audioFormat;
    };

    "Aegleseeker (Afterworld Full Version)" = fetchMusic {
      url = "https://www.youtube.com/watch?v=wq7BdtAFU5w&list=RDwq7BdtAFU5w&start_radio=1";
      hash = "sha256-6TUFn2sRaDLy3YITXOTk/aXUOdr57cW7FN17kGG8Lmo=";
      inherit audioFormat;
    };

    "Made of Light (Original Mix)" = fetchMusic {
      url = "https://www.youtube.com/watch?v=ZtxmZleZ25c&list=RDwq7BdtAFU5w&index=13";
      hash = "sha256-KWPAKWr65mf2Wwn5TuY00xR/NqM85Z9kj5woAcioYOo=";
      inherit audioFormat;
    };

    "STYX HELIX" = fetchMusic {
      url = "https://youtu.be/tIhL2KHVdgE?si=EHhDSxJvVYDNqVw3";
      hash = "sha256-wwdws/gdRExA1y0zBiKmMyBkI0HeBrq19P9hvffMF1g=";
      inherit audioFormat;
    };
  };
in

pkgs.linkFarm "tracks" (
  map (name: {
    name = "${name}.${audioFormat}";
    path = tracks.${name};
  }) (builtins.attrNames tracks)
)
