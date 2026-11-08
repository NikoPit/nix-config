# Environment

- The user is running a nix-based environment (NixOS, nix-darwin, nix-on-droid, etc), the configuration is at `~/nix`.
- If you need a command / program that is not installed, you can use `nix-shell` to provide them temporarily.

# New project

Follow these when your creating a new project:

- Create a flake.nix that provides the following (if applicable): A development shell, a package, a `nix run` target.

# Misc

- Ask the user before making important desisions, unless the user says otherwise.
