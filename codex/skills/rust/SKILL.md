---
name: rust
description: Apply the user's Rust engineering preferences to any project that uses or plans to use Rust. Use for early planning, architecture and technical design, project or workspace structure, crate and module boundaries, dependency choices, implementation, refactoring, debugging, and code review, even when the request does not yet name Rust files or Cargo manifests. Also use for Rust APIs and types, ownership, concurrency, error handling, unsafe code, FFI, tests, and Cargo tooling or verification.
---

# Rust Engineering

Inspect the repository and follow its established Rust conventions before applying these defaults. Use this skill together with workflow-specific skills such as `planning` or `code-review`; do not duplicate their process or output rules.

## Modules and files

- Keep files and functions focused. Split code when distinct responsibilities or ownership boundaries can be named, not merely to reduce line count.
- Use short top-level functions that expose multi-stage control flow through well-named operations. Keep phase-specific details in their owning modules.
- Spread a type's `impl` blocks across responsibility-based modules when one file would otherwise mix unrelated behavior.
- When a module needs child files, prefer `foo/mod.rs` with children under `foo/`; do not place `foo.rs` beside a `foo/` directory.
- Keep `lib.rs` focused on the crate boundary: crate documentation, module declarations, intentional public re-exports, and small composition logic.
- Keep unit tests near the code they cover. Use integration tests for public or cross-crate behavior. Do not create a separate test-only module merely to hide an oversized production module.

## Cargo workspace layout

- Prefer a multi-crate workspace when the project has clear responsibility or dependency boundaries. Keep a single crate when splitting would materially increase dependency management, build, release, or maintenance complexity without providing a meaningful architectural boundary.
- For a new multi-crate project, place crates directly under the project root by default:

  ```text
  project/
  ├── Cargo.toml
  ├── compositor/
  ├── desktop-manager/
  └── mcp/
  ```

- Do not introduce a `crates/` directory unless the existing repository already uses one or another concrete constraint justifies it.
- Name crate directories by responsibility without repeating the project name. Prefer `compositor` over `agent-virtual-desktop-compositor`. A published package name may include a prefix when global uniqueness requires it while the directory remains concise.
- Keep shared package metadata, lints, profiles, and dependencies in the root workspace manifest when multiple members use them.
- Declare shared dependencies in `[workspace.dependencies]` and inherit them from member crates with `dependency.workspace = true` rather than repeating versions and paths.
- Before implementing general-purpose functionality, check whether a maintained crate already provides it. Evaluate API fit, maintenance, soundness, licensing, target support, and `no_std` support when relevant.

## API and type design

- Make intent and invariants visible through names, types, ownership, module boundaries, and control flow.
- Keep public APIs as small as current callers require. Start private, then use `pub(crate)` or `pub` only at a real boundary.
- Attach behavior to the type or subsystem that owns the state. Prefer inherent methods or focused traits over scattered free functions.
- Use associated constructors or loaders for operations that create or recover a type.
- Prefer strong domain types and newtypes for identifiers, addresses, units, handles, validated inputs, and values with distinct invariants. Convert raw external representations at the boundary that validates them.
- Model closed sets with enums or bitflags. Use types and state transitions to make invalid states unrepresentable when that remains ergonomic.
- Avoid ambiguous boolean parameters and groups of loosely related values. Use an options struct, enum, or dedicated domain type when names and constraints matter.
- Prefer a public field when callers may freely read or replace it without validation, normalization, side effects, or invariant maintenance. Do not add mechanical getters and setters solely to hide data.
- Do not leak third-party or backend-specific types through unrelated public APIs. Keep them inside the owning subsystem or adapter.
- Use focused, preferably sealed traits for compile-time-selectable backends, and keep backend selection inside the owning adapter.

## Ownership and concurrency

- Express resource lifetimes through ownership, borrowing, RAII, `Drop`, and lexical scopes. Make the owner and destruction order clear.
- Use RAII when it clarifies cleanup and timing; use explicit operations when a guard would hide important lifecycle behavior. Name guard types with a `Guard` suffix.
- Prefer a smaller lexical scope over explicit `drop()` when it remains readable.
- Do not default to `Arc<Mutex<_>>` for shared architecture. First consider clearer ownership, message passing, task ownership, or narrower synchronization.
- Make lock ordering, atomicity, cancellation, and state observed outside locks explicit where they matter.

## Errors and incomplete behavior

- Add context at abstraction boundaries where it explains which operation or resource failed. Avoid logging an error and returning the same error when that causes duplicate reporting.
- Avoid `unwrap`, `expect`, and `panic!` in recoverable library paths. They are acceptable for tests and for genuine invariants when the message states the violated invariant.
- Do not silently ignore errors, report success for incomplete behavior, or conceal missing functionality behind a fallback.
- Complete refactors across all callers and remove obsolete paths. Keep old and new implementations in parallel only under an explicit migration plan.
- Mark intentional incomplete work with a specific `TODO` or `FIXME` that states what remains and, when useful, when it can be removed.

## Unsafe and FFI

- Keep unsafe operations local and expose a safe abstraction where practical.
- Do not put `SAFETY` comment around unsafe blocks.
- Model foreign and binary layouts with typed `#[repr(C)]` structures and explicit fields. Keep conversion at the owning boundary rather than manually indexing structured byte buffers throughout the codebase.
- Make ownership and release responsibility for FFI resources explicit. Do not allow Rust panics to cross an FFI boundary.
- Enable and respect `unsafe_op_in_unsafe_fn` so unsafe operations remain individually visible.

## Expression and documentation

- Prefer direct code and explicit invariants over clever compression, deeply nested control flow, or implicit conventions.
- Use names that express domain meaning. Avoid vague names such as `data`, `info`, `manager`, `handler`, or `process` when a more precise role is available.
- Do not use `#[allow(...)]` to suppress compiler warnings or lints by default. Fix the underlying issue instead; when suppression has a concrete, valid reason, scope it as narrowly as possible and document the reason next to the attribute.
- Use comments for rationale, invariants, ownership, lifecycle, and safety obligations. Do not restate obvious code.
- Keep macros small and narrowly scoped. Do not use them to conceal important control flow, unsafe operations, allocation, locking, or I/O.
- Add abstractions only for concrete reuse, a clear invariant, or a real boundary. Do not generalize for hypothetical future callers.

## Testing and verification

- Update tests with behavior changes and add a regression test for bug fixes when practical.
- Test observable behavior, boundaries, failure paths, and invariants rather than implementation steps.
- Avoid timing-based concurrency tests that depend on arbitrary sleeps. Prefer synchronization that makes the expected ordering deterministic.
- Use doctests for concise public API examples when they provide useful executable documentation.
- Run the repository's established Rust validation commands. When no stronger project-specific workflow exists, use the applicable subset of:

  ```sh
  cargo fmt --all -- --check
  cargo clippy --workspace --all-targets --all-features -- -D warnings
  cargo test --workspace --all-features
  cargo check --workspace --all-targets --all-features
  ```

- In a Nix-based project, run Cargo commands inside the repository's development shell when required.
