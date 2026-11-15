{ greeterSession, settings, lib, pkgs, ... }:

{
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "${lib.getExe pkgs.tuigreet} --time --remember --cmd ${greeterSession}";
        user = "greeter";
      };

      initial_session = {
        command = greeterSession;
        user = settings.user.name;
      };
    };
  };
}
