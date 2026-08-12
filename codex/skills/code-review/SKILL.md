---
name: code-review
description: Review code changes comprehensively, including bugs, security, architecture, code organization, API and type design, naming, readability, maintainability, performance, tests, documentation, repository consistency, and subjective style or aesthetic issues. Use when the user asks for a code review, PR review, diff review, design review of code, review findings, or feedback on an implementation.
---

# Code Review

Review the requested change in the context of the surrounding repository. Read relevant call sites, interfaces, tests, configuration, and project instructions before judging the diff.

## Review areas

Check all applicable areas:

- **Correctness:** requirements, regressions, boundary cases, state transitions, error propagation, resource cleanup, concurrency, cancellation, and platform behavior.
- **Security:** trust boundaries, validation, authorization, injection, unsafe operations, secrets, sensitive logging, path handling, and weakened security checks.
- **Architecture and ownership:** component responsibilities, dependency direction, layering, coupling, lifecycle ownership, duplicated mechanisms, unnecessary abstractions, and abstraction leaks.
- **Code organization:** oversized files, mixed responsibilities, misplaced behavior, weak module boundaries, and catch-all modules such as `types`, `state`, `utils`, `common`, or `helpers` where domain-oriented modules would be clearer.
- **API and type design:** public surface area, consistency, misuse resistance, invalid states, ownership semantics, failure modes, extensibility, and compatibility.
- **Naming and readability:** misleading, vague, inconsistent, or overly generic names; difficult control flow; overly long functions; hidden assumptions; and comments that obscure or merely repeat the code.
- **Maintainability:** duplication, scattered changes for one behavior, implicit ordering, hidden global state, dead paths, temporary compatibility code, and future changes made unnecessarily difficult.
- **Performance and resources:** algorithmic regressions, unnecessary allocation or copying, blocking work, excessive I/O, lock contention, repeated work, and unbounded queues, caches, tasks, or memory growth.
- **Tests:** missing coverage, weak assertions, untested failure paths, flaky dependencies, excessive mocking, and tests that do not protect the changed behavior.
- **Documentation and contracts:** inaccurate public documentation, unclear configuration or CLI behavior, stale comments, missing prerequisites or side effects, and README content that exposes unnecessary implementation detail.
- **Repository consistency:** violations of project instructions, established patterns, formatting, dependency policy, supported platforms, feature flags, minimum versions, or naming conventions.
- **Style and aesthetics:** awkward naming, clumsy expression, inconsistent structure, visual noise, unnecessarily clever code, poor local symmetry, or code that is technically valid but unpleasant to read.

## Findings

Lead with findings ordered by severity and then by impact. Use these labels:

- `Critical`: exploitable security issue, data loss, or systemic failure.
- `High`: definite bug, serious regression, concurrency failure, or major API break.
- `Medium`: concrete design, organization, maintainability, performance, or test problem likely to cause misuse or future defects.
- `Low`: limited-impact clarity, consistency, documentation, or maintainability issue.
- `Nit`: subjective naming, formatting, expression, or aesthetic preference.

For each finding:

1. Give a concise title with the severity.
2. Cite the narrowest relevant file and line.
3. Explain the specific issue and its consequence. For a `Nit`, explain the preferred alternative without inventing a concrete risk.
4. Suggest a practical direction for improvement when it is not obvious.

Do not inflate severity to make a style concern sound objective. Do not omit design or aesthetic feedback merely because the code currently works.

## Response shape

Present findings first. After the findings, include open questions or assumptions only when needed, followed by a brief summary. If there are no findings in any category, say so clearly and mention any remaining test gaps or residual risk.
