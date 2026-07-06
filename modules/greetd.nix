{ greetdSession, settings, ... }:

let
  session = {
    command = greetdSession;
    user = settings.user.name;
  };
in
{
  services.greetd = {
    enable = true;

    settings = {
      initial_session = session;
      default_session = session;
    };
  };
}
