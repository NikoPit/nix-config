{
  imports = [
    ../niri/conf.nix
    ./greetd.nix
    ./misc.nix
    ../nixvim/nixvim.nix
    ./sudo.nix
    ./nix.nix
    ./fish.nix
    ./xwayland.nix
    ./distcc.nix
    ./stylix.nix
    ./steam.nix
    ./electron-wl.nix
    ./command-not-found.nix
    # TODO ./file-chooser.nix
    ./flatpak.nix
    ./man.nix

    ../script/scripts.nix
  ];
}
