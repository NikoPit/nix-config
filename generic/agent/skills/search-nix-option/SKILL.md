---
name: search-nix-option
description: Use whenever you need to find a NixOS or Home Manager option — including options from third-party flakes (stylix, disko, sops-nix, nixvim, ...) — whether it exists, its type, its default, or what it does.
---

# Nix option search

Finds whether a NixOS or Home Manager option exists, its type, default, and
description. It covers not only base NixOS / home-manager options but also options provided
by the third-party flakes the user imports (stylix, disko, sops-nix,
nixos-hardware, nixvim, ...).

## How to run

One `nix eval` call checks both NixOS and Home Manager. `kw` is taken from the
`KW` env var, and `HOSTNAME` selects the NixOS host to search, so no shell
quoting is needed:

```bash
# Keyword search (matches anywhere in the dotted option path)
HOSTNAME="$(hostname)" KW=<keyword> nix eval --impure --raw \
  --expr 'import ~/.pi/agent/skills/search-nix-option/search.nix { }'

# Exact-path check (verify a specific option path exists)
HOSTNAME="$(hostname)" KW=<a.b.c> nix eval --impure --raw \
  --expr 'import ~/.pi/agent/skills/search-nix-option/search.nix { exact = true; }'
```

Examples:

```bash
HOSTNAME="$(hostname)" KW=openssh nix eval --impure --raw --expr 'import ~/.pi/agent/skills/search-nix-option/search.nix { }'
HOSTNAME="$(hostname)" KW=services.openssh.ports nix eval --impure --raw --expr 'import ~/.pi/agent/skills/search-nix-option/search.nix { exact = true; }'
HOSTNAME="$(hostname)" KW=stylix nix eval --impure --raw --expr 'import ~/.pi/agent/skills/search-nix-option/search.nix { }'
```

Output is grouped by source (`NixOS (host)` / `Home Manager`). Each hit shows
the full dotted path, `type`, `default`, and `desc`.

## When to use which mode

- **Keyword search** (`exact` omitted): use when the exact option name isn't
  known. Results may be many; match on words likely unique to the feature
  (e.g. `openssh`, `kitty`, `stylix`).
- **Exact path** (`exact = true`): use when a full option path
  (e.g. `services.openssh.ports`) is given and you need to confirm it exists
  and see its type/default. Reports `NOT FOUND` only if the path is truly not
  declared.

## Interpretation notes

- With `exact = true`, a hit may be a **leaf option** (shows `type`/`default`)
  or a **namespace** (a container like `services.openssh`, shown with its
  option count). A namespace is not itself settable — set one of its
  sub-options instead.
- The same concept may live under different names in NixOS vs Home Manager.
  For example SSH is `services.openssh.*` in NixOS but `programs.ssh.*` in
  Home Manager — search the keyword and check both groups.
- A `default` of `<unset>` means the option has no explicit default;
  `<null>` means the default really is `null`. `<set>` / `<attrs>` means the
default is a structured value.
- Third-party options are found exactly where the flake declares them, e.g.
  `stylix.fonts.*`, `disko.devices`, `sops.age.*` (NixOS) and
  `programs.nixvim.*`, `stylix.targets.*` (Home Manager).
- The first search after a config change can take ~30s (cold evaluation of the
  full option trees); subsequent searches are fast (~1-3s).
- If the searched host doesn't exist (e.g. `HOSTNAME` doesn't match any
  `nixosConfigurations` key in `~/nix/flake.nix`), `search.nix` errors out.
  Fix by passing the right `host` argument. If `HOSTNAME` is empty, it prints
  a message asking for it.
