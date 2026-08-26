rec {
  proxy = import ./proxy.nix;
  misc = import ./misc.nix;
  user = import ./user.nix;
  localization = import ./localization.nix;
  palette = import ./palette.nix;
}
