{
  sops = {
    defaultSopsFile = ../secrets.yaml;

    age = {
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };
  };
}
