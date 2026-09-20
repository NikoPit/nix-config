{ settings, ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = true;

    settings = {
      AllowUsers = [ settings.user.name ];
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  programs.mosh = {
    enable = true;
    openFirewall = true;
  };

  users.users.${settings.user.name}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDGKNnGONe4UkyPU+3rcM1JWd7VdozYiKBjbhn1gKYEN"
  ];
}
