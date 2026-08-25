---
name: write-readme
description: Create, rewrite, review, or update project README files. Use whenever a task involves README.md content, including documenting a new project, correcting an existing README, adding installation or development instructions, or writing library examples and usage guidance.
---

# Write README

Write a concise, user-facing entry point to the project. Inspect the repository first and derive every command, requirement, and capability from the source or build configuration. Do not invent missing details.

## Default structure

Use this order when the sections apply:

```markdown
# PROJECT_NAME

Short description.

More precise project description when it adds useful context.

## Example

A minimal working example for a library.

## Usage

The basic public usage of a library or command-line tool.

## Development

The shortest reproducible instructions for entering the development environment and working on the project.

## Installation

Supported installation instructions for end users.
```

Treat this as a default shape, not a mandatory template. Omit empty, redundant, speculative, or irrelevant sections. Add another section only when users need it to adopt or operate the project.

## Content rules

- Start with the exact project name and explain plainly what it does.
- Keep the opening description compact. State the project's purpose before secondary context.
- For libraries, prefer one minimal, runnable `Example` followed by concise `Usage` guidance for the public API.
- For applications, document the normal user workflow instead of forcing library-oriented sections.
- Keep `Development` contributor-focused. Include prerequisites and verified setup commands such as `nix develop`, `./bootstrap`, build, test, and formatting commands only when they are genuinely required.
- Keep `Installation` user-focused and separate from development setup. Document only supported installation methods.
- Prefer copyable commands and small examples over explanatory prose.
- Preserve useful existing information when editing a README, but remove stale, duplicated, or generic boilerplate.

## Exclusions

- Do not describe internal architecture, module boundaries, control flow, implementation decisions, or source file listings unless the user explicitly requests technical documentation in the README.
- Do not narrate the development process or summarize the codebase file by file.
- Do not add marketing language, feature padding, badges, roadmaps, contribution guides, FAQ sections, or license sections without a concrete need.
- Do not duplicate information better maintained in generated API documentation, source comments, or dedicated contributor documentation.
- Do not create a README merely because a new directory or crate was added. Create or expand one only when requested or necessary for users to use the project.

Before finishing, verify that documented commands and examples match the repository and that every section helps a reader install, use, or develop the software.
