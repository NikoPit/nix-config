---
description: Analyze the root cause of a mistake and codify a prevention mechanism
argument-hint: "<mistake description>"
---

You (the agent) made the following mistake: $@

Do not just fix it this once. The goal is to ensure this mistake never happens again. Follow this process:

1. **Restate and confirm**: Restate the mistake in one or two sentences. If the description is vague, ask me to clarify before guessing.
2. **Identify the root cause**: State precisely why the mistake happened, not just what happened.
3. **Propose a prevention mechanism**: Describe the concrete guardrail that prevents recurrence and why it works.
4. **Choose where to codify it** (most appropriate option, can combine):
   - Global AGENTS.md (`~/nix/generic/agent/AGENTS.md`) — applies to all projects
   - Project AGENTS.md — applies to this project only
   - A skill — when it is a reusable workflow
   - A prompt template — when it fits a fixed-trigger workflow
   - Code-local comments — when the rule belongs to a specific code path
5. **Execution**: Show the full draft (the AGENTS.md entry or skill content to add) and wait for my confirmation before writing files.

Finally, summarize: which file was changed and how my future behavior will differ.
