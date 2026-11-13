{ config, lib, pkgs, ... }:

let
  sopsService = config.systemd.user.services.sops-nix;
  sopsEnvironment = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (
      name: value: "export ${name}=${lib.escapeShellArg (toString value)}"
    ) config.sops.environment
  );
  sopsCommand = lib.concatStringsSep " " (
    map (command: lib.escapeShellArg (toString command)) sopsService.Service.ExecStart
  );
  decryptSecrets = pkgs.writeShellScript "decrypt-secrets" ''
    ${sopsEnvironment}
    ${sopsCommand}
  '';
in
{
  home.activation.sops-nix = lib.mkForce ''
    run ${decryptSecrets}
  '';

  shellHooks = [
    ''
      ${decryptSecrets}
    ''
  ];
}
