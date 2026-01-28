{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      maple-mono.NF-CN
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Maple Mono NF CN" ];
        sansSerif = [ "Maple Mono NF CN" ];
        monospace = [ "Maple Mono NF CN" ];
      };
    };
  };
}
