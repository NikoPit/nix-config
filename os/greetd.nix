{ pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "hyprland";
        user = "elysia";
      };

      # The session when you log out of hyprland / hyprland breaks
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -cmd hyprland";
        user = "greeter";
      };
    };
  };
}
