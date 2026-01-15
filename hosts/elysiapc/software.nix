{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ 
    obs-studio
    hyprpicker
    lug-helper
  ];
}
