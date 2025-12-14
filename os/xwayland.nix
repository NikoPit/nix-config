{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  programs.xwayland.enable = true;
}
