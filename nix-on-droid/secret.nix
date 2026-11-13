{ config, lib, ... }:

let
  sopsService = config.systemd.user.services.sops-nix;
  sopsEnvironment = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (
      name: value: "export ${name}=${lib.escapeShellArg (toString value)}"
    ) config.sops.environment
  );
  sopsFishEnvironment = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (
      name: value: "set -gx ${name} ${lib.escapeShellArg (toString value)}"
    ) config.sops.environment
  );
  sopsCommand = lib.concatStringsSep " " (
    map (command: lib.escapeShellArg (toString command)) sopsService.Service.ExecStart
  );
in
{
  home.activation.sops-nix = lib.mkForce ''
    ${sopsEnvironment}
    ${sopsCommand}
  '';

  shellHooks = [
    ''
      ${sopsFishEnvironment}
      ${sopsCommand}
    ''
  ];
}
