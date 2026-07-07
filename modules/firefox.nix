{ config, ... }:
{
  programs.firefox = {
    enable = true;
    configPath = "${config.xdg.configHome}/mozilla/firefox";

    policies.ExtensionSettings = {
      "uBlock0@raymondhill.net" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        installation_mode = "force_installed";
      };

      # Return youtube dislikes
      "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
        installation_mode = "force_installed";
      };

      # Bewlybewly
      "addon@bewlybewly.com" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/file/4444302/bewlybewly-0.41.1.xpi";
        installation_mode = "force_installed";
      };

      # Don't track me google
      "dont-track-me-google@robwu.nl" = {
        install_url = "https://addons.mozilla.org/firefox/downloads/file/4132891/dont_track_me_google1-4.28.xpi";
        installation_mode = "force_installed";
      };
    };
  };
}
