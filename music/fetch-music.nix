{ pkgs }:

{
  url,
  hash,
  audioFormat,
}:

pkgs.stdenvNoCC.mkDerivation {
  pname = "fetch-music";
  version = "1";

  nativeBuildInputs = [ pkgs.yt-dlp ];

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  outputHashMode = "flat";
  outputHashAlgo = "sha256";
  outputHash = hash;

  installPhase = ''
    tmp="$(mktemp -d)"

    yt-dlp \
      --no-playlist \
      -x \
      --audio-format ${audioFormat} \
      -o "$tmp/track.%(ext)s" \
      ${pkgs.lib.escapeShellArg url}

    file="$(find "$tmp" -maxdepth 1 -type f | head -n1)"

    test -n "$file"
    cp "$file" "$out"
  '';
}
