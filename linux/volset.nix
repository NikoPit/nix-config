{ pkgs, ... }:

{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "volset";
      runtimeInputs = [ pkgs.wireplumber ];
      text = ''
        if [[ $# -ne 1 ]]; then
          echo 'Usage: volset 50% | 5%+ | 5%-' >&2
          exit 1
        fi

        exec wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ "$1"
      '';
    })
  ];
}
