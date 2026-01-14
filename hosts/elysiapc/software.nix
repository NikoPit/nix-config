{ pkgs, nix-citizen , ... }:

{
  environment.systemPackages = with pkgs; [ 
    obs-studio
    hyprpicker
    nix-citizen.packages.${system}.rsi-launcher
  ];
}
