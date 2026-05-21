# arqqitect: Review

Review one chapter or all chapters of the HLD for gaps, inconsistencies, and risks.
Write findings to `docs/10-raid/issues.md`.

## Step 1 — Determine scope

Check `$ARGUMENTS`:
- If a chapter identifier is provided (e.g. `07-security`), review that chapter only.
- If `all` is provided, review all chapters in `docs/`.
- If nothing is provided, ask: "Review one chapter or all? If one chapter, which?"

## Step 2 — Read the content

Read all Markdown files in the target chapter folder(s).
If reviewing `all`, read all files in `docs/` before forming any findings.

## Step 3 — Identify findings

For each chapter reviewed, identify:

**Gaps** — Content that is expected for this chapter but missing or too vague to be useful.
Use each chapter's README.md as the reference for what is expected.
Flag: incomplete sections, placeholder text, missing diagrams, unexplained acronyms.

**Inconsistencies** — Conflicts between chapters.
Examples: security chapter mentions IAM approach X, but application chapter assumes approach Y.
Data chapter defines retention as 90 days, operations chapter references 30 days.

**Risks** — Decisions or omissions that introduce architectural risk.
Examples: no DR strategy defined, single point of failure not acknowledged, compliance requirement with no control mapped.

## Step 4 — Write findings to 10-raid/issues.md

Append findings to `docs/10-raid/issues.md`. If the file does not exist, create it.

Format each finding as:

```
## [YYYY-MM-DD] Review finding: <short title>

**Type:** Gap | Inconsistency | Risk
**Chapter:** <chapter folder name>
**Finding:** <One paragraph describing the issue specifically — reference the exact section or file>
**Suggested action:** <What the architect should do to resolve this>
**Status:** Open
```

## Step 5 — Summarise

After writing all findings, print a summary:
- Total findings by type (gaps / inconsistencies / risks)
- Which chapters have the most issues
- Recommended priority order for fixing them
