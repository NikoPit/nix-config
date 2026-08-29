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
