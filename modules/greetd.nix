{ pkgs, settings, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "niri-session";
        user = settings.user.name;
      };

      # The session when you log out of hyprland / hyprland breaks
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet -cmd niri";
        user = "greeter";
      };
    };
  };
}
