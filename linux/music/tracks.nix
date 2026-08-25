{ pkgs, ... }:

let
  audioFormat = "mp3";
  fetchMusic = import ./fetch-music.nix { inherit pkgs; };

  makeTrackEntry =
    { url, hash }:
    fetchMusic {
      inherit url hash audioFormat;
    };

  tracks = {
    "Angel Dust (2008 Mix)" = makeTrackEntry {
      url = "https://www.youtube.com/watch?v=jszUs6TvsI8";
      hash = "sha256-6n6SJ7ChYxwV+iWkC/+5yb4O9yEZERecWTeM7RhCsS8=";
    };

    "Aegleseeker (Afterworld Full Version)" = makeTrackEntry {
      url = "https://www.youtube.com/watch?v=wq7BdtAFU5w&list=RDwq7BdtAFU5w&start_radio=1";
      hash = "sha256-6TUFn2sRaDLy3YITXOTk/aXUOdr57cW7FN17kGG8Lmo=";
    };

    "Made of Light (Original Mix)" = makeTrackEntry {
      url = "https://www.youtube.com/watch?v=ZtxmZleZ25c&list=RDwq7BdtAFU5w&index=13";
      hash = "sha256-KWPAKWr65mf2Wwn5TuY00xR/NqM85Z9kj5woAcioYOo=";
    };

    "STYX HELIX" = makeTrackEntry {
      url = "https://youtu.be/tIhL2KHVdgE?si=EHhDSxJvVYDNqVw3";
      hash = "sha256-wwdws/gdRExA1y0zBiKmMyBkI0HeBrq19P9hvffMF1g=";
    };

    "I really wanna stay at your house" = makeTrackEntry {
      url = "https://www.youtube.com/watch?v=KvMY1uzSC1E&list=RDKvMY1uzSC1E&start_radio=1";
      hash = "sha256-eLRnUV/wD8ZatPciM+8EfVcwoLNK+eDpQmMiOTNuOYs=";
    };

    "Starfall" = makeTrackEntry {
      url = "https://youtu.be/CKerqp5yOGo?si=yiA-1UyMRx6jsK3K";
      hash = "sha256-ekLe5muQg7SG1io3PxlkdQG00viVnfDREzcfIQwYveM=";
    };

    "Da Capo" = makeTrackEntry {
      url = "https://www.youtube.com/watch?v=9iFDPYubUbE&list=RDHQnC1UHBvWA&index=15";
      hash = "sha256-KZQkQiJF6lHwlU7RODQibZd2crXfXHDjwTBcCaq2Row=";
    };

    "Shelter" = makeTrackEntry {
      url = "https://youtu.be/HQnC1UHBvWA?si=kXCL9sFpbb6xEEcH";
      hash = "sha256-Do4La5NZpfX+xUTTRhHiAfeRZZB8/955Rw0SsFjl314=";
    };
  };
in

pkgs.linkFarm "tracks" (
  map (name: {
    name = "${name}.${audioFormat}";
    path = tracks.${name};
  }) (builtins.attrNames tracks)
)
