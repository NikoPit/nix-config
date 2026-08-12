# Global instructions

## Environment

- The user runs NixOS.
- Do not assume FHS paths or globally installed development tools.
- When required software is unavailable, use a temporary `nix-shell` environment to provide it.
- Prefer packages from Nixpkgs over language-specific global package installations.
- Do not modify the user's system-wide Nix configuration unless explicitly requested.

## Network

- The user is located in China and accesses some network resources through a proxy, so network connections may occasionally be unstable.
- Treat transient timeouts, connection resets, and mirror failures as potentially recoverable; retry a reasonable number of times before reporting failure.
- Do not disable TLS verification or other security checks to work around network failures.

## Project setup

- When setting up a new project, prefer using a Nix development shell defined in `flake.nix` for installing dependencies.
- Prefer `nix develop` as the documented way to enter the development environment.
- Also add `use flake` in `.envrc` for `direnv` users.

## Working practices

- Use English for code, comments, identifiers, commit messages, and technical documentation unless the project specifies otherwise.
- Always communicate with the user in Chinese.

## Instruction precedence

- Project-specific `AGENTS.md` instructions may override these global instructions.
- When instructions conflict, follow the more specific project instructions.
