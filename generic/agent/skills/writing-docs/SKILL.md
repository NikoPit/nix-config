---
name: writing-docs
description: Use when writing, updating, or reviewing any documentation — skills, AGENTS.md and any instructions to agents, READMEs, DESIGN.md, code comments.
---

# Writing and Updating Documentation

Documentation is authoritative: agents and humans rely on it, and a wrong doc misleads every
downstream reader.

## Before writing: verify every factual claim

- Never state behavior, mechanism, or layout claims from inference or memory. Always verify them.
- When a claim is an unverified observation, mark it explicitly as unverified; do not phrase it
  as established fact.

## Keep documentation proportional

- Write the shortest text that preserves the necessary behavior and constraints.
- For a simple concept, prefer one sentence. Use a paragraph only when it states multiple independent constraints that readers must understand.
- Keep a sentence only if omitting it could cause a concrete misunderstanding, misuse, or maintenance error.
- Do not explain things that project contributors are likely to know already, that the nearby code makes obvious, or
  that do not help someone understand or modify this location. Add context only when the behavior or constraint is
  non-obvious and materially useful here.

### Example: Roxy OS ABI comments

Prefer:

```c
/* The dirfd selector is a magic value in the fd argument for the current
 * working directory; it is separate from AT_* flags. */

/* The base keeps Roxy ioctl values distinct from ordinary Linux ioctl values. */
```

Avoid:

```c
/*
 * Roxy's dirfd selector and AT_* flags.
 *
 * The two are separate arguments with separate shapes. dirfd is a descriptor
 * plus one magic selector: a descriptor is never negative, so the working
 * directory is spelled as a negative value no descriptor can hold. A negative
 * value this header does not name is another personality's numbering, and the
 * kernel reports such a caller as foreign instead of reading it as a request
 * of its own.
 *
 * AT_* is a flag word, so every flag is one bit from a base above Linux's
 * whole range for the word. Roxy defines only the flags it accepts, while
 * other flags remain absent.
 *
 * The kernel side is kernel/syscall/src/syscalls/fs/mod.rs and
 * kernel/syscall/src/syscalls/fs/dir.rs.
 */
```

The second comment is excessive for this location: it repeats details that are obvious from the nearby code or already
familiar to project contributors, names source paths, and adds background that is not needed to use or modify these
definitions. The shorter comment states the only non-obvious distinction relevant here.

Before keeping additional context, ask whether it explains behavior or a constraint that is not obvious from the
nearby code and is useful for understanding or modifying this location. If not, leave it out or move it to a design
document only when the broader context is genuinely needed there.

## While writing: keep terminology consistent

- Reuse existing terms; do not introduce new names for concepts that already have one.
- If your change contradicts an existing statement anywhere, fix that statement in the same
  change — do not leave the repo internally inconsistent.

## After writing: sweep the repo for consistency

- Search the repository for every key term or concept you touched, e.g.
  `rg -in 'term1|term2|concept' .` (and the relevant docs tree), and read each hit.
- Confirm each statement is still true under your change; update stale or contradictory text in
  the same change.
- Re-read your diff and the surrounding docs once before finalizing.

## Review checklist

- [ ] Every factual claim verified against implementation, tool output, or authority
- [ ] No contradictory statements remain anywhere in the repo for the touched concepts
- [ ] `git diff --check` clean (or equivalent whitespace check)
- [ ] Terminology matches existing docs
