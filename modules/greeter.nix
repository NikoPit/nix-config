{ greeterSession, settings, ... }:

{
  services.greetd = {
    enable = true;

    settings.initial_session = {
      command = greeterSession;
      user = settings.user.name;
    };
  };
}
