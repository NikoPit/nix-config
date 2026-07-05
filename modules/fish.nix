{
  programs.fish = {
    enable = true;

    shellInit = ''
      if test -z "$__NIXOS_SET_ENVIRONMENT_DONE"
        source /etc/fish/nixos-env-preinit.fish
      end
    '';
  };
}
