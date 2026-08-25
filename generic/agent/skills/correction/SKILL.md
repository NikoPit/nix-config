---
name: correction
description: Do not use this skill unless the user explicitly invokes $correction.
disable-model-invocation: true
metadata:
  opencode/autoinvoke: false
---

# Correction

The user is providing one or more proposed corrections to your previous work.

A correction is not an unconditional instruction to change the code. The user
may be wrong, may have misunderstood the previous work, or may not fully
understand the relevant implementation.

For each correction:

1. Inspect the relevant code, previous work, and surrounding context.
2. Determine whether the correction is correct and applicable.
3. If it is correct, apply it and verify the result.
4. If it is incorrect, do not apply it. Explain clearly why it is incorrect.
5. If it is ambiguous or marked `unsure`, investigate it before deciding:
   - explain how the relevant code works;
   - explain whether the proposed correction is justified;
   - apply it if it is correct;
   - do not apply it if it is incorrect;
   - ask for clarification only when the available context is insufficient
     to make a reliable decision.

Do not blindly follow a correction. Reject it when it is technically
incorrect, based on a misunderstanding, inconsistent with the existing design,
or likely to introduce a regression.

A correction does not authorize unrelated changes. Keep changes limited to the
correction being evaluated and its necessary consequences.

## Multiple corrections

Process multiple corrections independently and preserve their numbering.

For input such as:

```text
1. <CORRECTION_1>
2. <CORRECTION_2>
```

produce a response with the same structure:

```text
1. <RESPONSE_TO_CORRECTION_1>
2. <RESPONSE_TO_CORRECTION_2>
```

Do not merge multiple corrections into one undifferentiated response.

For each correction, clearly state one outcome:

- `Applied` — the correction was valid and was implemented.
- `Rejected` — the correction was invalid or based on a misunderstanding.
- `Already satisfied` — the current work already follows the correction.
- `Needs clarification` — the available context is insufficient to decide.

When applying a correction, briefly summarize the change and report the
verification performed. When rejecting a correction, explain the technical
reason instead of silently ignoring it.
