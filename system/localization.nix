{ settings, ... }:
let
  localizationSettings = settings.localization;
in
{
  # Set your time zone.
  time.timeZone = localizationSettings.timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = localizationSettings.language;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = localizationSettings.regionalFormat;
    LC_IDENTIFICATION = localizationSettings.regionalFormat;
    LC_MEASUREMENT = localizationSettings.regionalFormat;
    LC_MONETARY = localizationSettings.regionalFormat;
    LC_NAME = localizationSettings.regionalFormat;
    LC_NUMERIC = localizationSettings.regionalFormat;
    LC_PAPER = localizationSettings.regionalFormat;
    LC_TELEPHONE = localizationSettings.regionalFormat;
    LC_TIME = localizationSettings.regionalFormat;
  };
}
