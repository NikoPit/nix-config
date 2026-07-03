{
  imports = [
    ../niri/conf.nix
    ./greetd.nix
    ./misc.nix
    ../nixvim/nixvim.nix
    ./sudo.nix
    ./nix.nix
    ./user.nix
    ./fish.nix
    ./xwayland.nix
    ./distcc.nix
    ./steam.nix
    ./electron-wl.nix
    ./fonts.nix
    ./command-not-found.nix
    # TODO ./file-chooser.nix
    ./substituters.nix
    ./flatpak.nix
    ./man.nix

    ../script/scripts.nix
  ];
}
