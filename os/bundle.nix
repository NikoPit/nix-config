{
  imports = [
    ../niri/conf.nix
    ./greetd.nix
    ./v2raya.nix
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
    ./file-chooser.nix
    ./substituters.nix
    ./flatpak.nix

    ../script/scripts.nix

    ../test/openprt.nix
  ];
}
