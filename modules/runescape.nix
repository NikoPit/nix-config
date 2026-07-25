{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.bolt-launcher.override { enableRS3 = true; })
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];
}
