{ pkgs, ... }:

{
  home.packages = [ pkgs.qq ];

  autostarts = [
    {
      command = "${pkgs.qq}/bin/qq";
      workspace = "9";
    }
  ];
}
