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
    # sops puts decrypted secrets in the XDG runtime directory. Nix-on-Droid
    # has no XDG session here, so use a private temporary directory instead.
    runtimeDir="''${TMPDIR:-/tmp}/nix-on-droid-runtime-$(id -u)"
    mkdir -p "$runtimeDir"
    chmod 700 "$runtimeDir"
    export XDG_RUNTIME_DIR="$runtimeDir"

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
