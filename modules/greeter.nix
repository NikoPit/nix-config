{ greeterSession, settings, pkgs, ... }:

{
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd ${greeterSession}";
        user = "greeter";
      };

      initial_session = {
        command = greeterSession;
        user = settings.user.name;
      };
    };
  };
}
