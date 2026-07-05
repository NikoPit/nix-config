{ greetdSession, settings, ... }:

{
  services.greetd = {
    enable = true;

    settings.initial_session = {
      command = greetdSession;
      user = settings.user.name;
    };
  };
}
