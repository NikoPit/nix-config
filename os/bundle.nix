{
  # TODO
  services.v2raya.enable = true;
  imports = [
    ../niri/conf.nix
    ./greetd.nix
    ../nixvim/nixvim.nix
    ./sudo.nix
    ./user.nix
    ./fish.nix
    ./xwayland.nix
    ./steam.nix
    ./electron-wl.nix
    ./bootloader.nix
    ./fonts.nix
    ./command-not-found.nix
    # TODO ./file-chooser.nix
    ./substituters.nix
    ./flatpak.nix

    ../script/scripts.nix
  ];
}
