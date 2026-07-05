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
      initial-session = session;
      default-session = session;
    };
  };
}
