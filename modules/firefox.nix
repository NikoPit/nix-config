{
  config,
  firefox-addons,
  pkgs,
  ...
}:
{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    profiles.default = {
      isDefault = true;
      path = "iuhwjerr.default";

      extensions = {
        force = true;
        packages = with firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
          ublock-origin
          return-youtube-dislikes
          dont-track-me-google1
          privacy-badger
        ];
      };
    };
  };
}
