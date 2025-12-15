{
  imports = [
    ./niri.nix
    ./greetd.nix
    ./v2raya.nix
    ./nixvim/nixvim.nix
    ./sudo.nix
    ./user.nix
    ./fish.nix
    ./xwayland.nix
    ./steam.nix
    ./graphics-driver.nix
    ./electron-wl.nix
    ./desktop-portal.nix
    ./bootloader.nix

    ../script/scripts.nix
  ];
}
