{
  proxy = import ./proxy.nix;
  style = import ./style.nix;

  nixGC.dates = "daily";
}
