{ settings, ... }:

{
  sops = {
    defaultSopsFile = ../secrets.yaml;

    age = {
      keyFile = "/home/${settings.user.name}/.key.txt";
      generateKey = true;
    };
  };
}
