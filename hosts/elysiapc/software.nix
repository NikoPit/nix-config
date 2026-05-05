{ pkgs , ... }:

{
  environment.systemPackages = with pkgs; [ 
    obs-studio
    hyprpicker
    bolt-launcher
    xwayland-run
    umu-launcher
    protonplus
  ];
}
