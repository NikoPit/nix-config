{ lib, pkgs, ... }:

{
  home.packages = [ pkgs.qq ];

  autostarts = [
    {
      command = lib.getExe pkgs.qq;
      workspace = "9";
    }
  ];
}
