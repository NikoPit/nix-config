{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      maple-mono.CN
    ];
  };
}
