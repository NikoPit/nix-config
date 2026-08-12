---
name: planning
description: Produce and revise implementation-ready software plans. Use when Codex operates in Plan mode or the user requests an implementation plan, architecture or technical design, refactoring plan, project structure, implementation approach, or a change to a previously proposed plan.
---

# Planning

Inspect the repository before proposing a plan. Base every decision on the existing architecture, conventions, dependencies, public interfaces, and constraints. Resolve important implementation decisions instead of deferring them to the coding phase.

## Plan contents

Scale the detail to the task, but make the plan sufficient for implementation without repeating repository discovery.

Include the following when applicable:

1. State the scope, relevant existing behavior, assumptions, and explicit non-goals.
2. Show the proposed file structure. Identify files or directories to add, modify, move, or delete and state the responsibility of each affected component.
3. Describe architectural boundaries, ownership, dependencies, and communication between components.
4. Specify public API changes with relevant function, method, type, trait, endpoint, command, event, or configuration signatures.
5. Explain important data flow, control flow, lifecycle, concurrency, persistence, and error handling.
6. Include concise pseudocode and draft structs, types, traits, or interfaces when they clarify a substantial design.
7. Order implementation steps by dependency and identify migration or compatibility work.
8. Define verification through focused tests, integration checks, and manual validation where appropriate.

Do not use vague placeholders such as "handle as needed", "wire everything up", or "add appropriate error handling" for decisions that can be resolved during planning.

Do not add artificial sections, abstractions, pseudocode, or type definitions to a small and local change. A short plan is acceptable when it still identifies the exact files, behavior, and verification involved.

## File structure

Present a compact tree for structural changes. Annotate only affected or important paths rather than listing the entire repository.

```text
project/
├── component-a/
│   └── src/...
└── component-b/
    └── src/...
```

## Public API

Make externally visible and cross-module contracts concrete. Use draft signatures rather than prose alone when possible.

```rust
pub struct DesktopManager {
    // Fields that establish ownership and lifecycle.
}

impl DesktopManager {
    pub fn create(&mut self, options: CreateOptions) -> Result<DesktopInfo, CreateError>;
    pub fn destroy(&mut self, id: DesktopId) -> Result<(), DestroyError>;
}
```

The drafts do not need to compile, but they must communicate ownership, inputs, outputs, and failure modes accurately.

## Revising an existing plan

When the user requests changes to an existing plan, edit that plan in place rather than rewriting it. Preserve all unaffected content and update only the parts required by the request and their direct dependencies. Reissue the complete updated plan after making the changes.
