# arqqitect — Design Spec

**Date:** 2026-05-20
**Author:** Quique Sanchez

---

## What arqqitect is

A GitHub template repository that treats architecture documentation as code. One repo is forked per engagement. It provides the folder structure, CI pipelines, and AI skills to author, review, and publish HLD documents — and to hand off engineering specs to the downstream spec-kit layer.

---

## Architecture

**One repo, two concerns:**

- **Structure and tooling** — folder hierarchy, Markdown skeletons, GitHub Actions, PR templates, scripts. Lives at the repo root. Customised per engagement after forking.
- **AI skills** — three Claude Code project-local skills in `.claude/skills/`. Picked up automatically when working in the repo. No plugin installation required.

---

## Repo Structure

```
arqqitect/  ← GitHub template repo, forked once per engagement
├── .claude/
│   └── skills/
│       ├── draft.md
│       ├── review.md
│       └── generate-slides.md
├── CLAUDE.md                        ← engagement metadata + AI instructions
├── .github/
│   ├── pull_request_template.md
│   └── workflows/
│       ├── render-pdf.yml           ← pandoc → output/pdf/ on merge to main
│       ├── render-slides.yml        ← Marp → output/slides/ on merge to main
│       └── generate-specs.yml       ← generate-specs.sh on merge to main
├── docs/
│   ├── 00-introduction/             ← document control, scope, authors, design principles
│   ├── 01-context/                  ← business reasons, context, dependencies
│   ├── 02-requirements/             ← functional, non-functional, security requirements
│   ├── 03-integration/
│   ├── 04-application/
│   ├── 05-infrastructure/
│   ├── 06-data/
│   ├── 07-security/
│   ├── 08-deployment/
│   ├── 09-operations/
│   ├── 10-raid/                     ← risks, assumptions, issues, decisions (ADRs)
│   └── 11-appendices/               ← licensing, taxonomy, abbreviations, references
├── output/
│   ├── pdf/
│   ├── slides/
│   └── specs/
└── scripts/
    └── generate-specs.sh
```

---

## AI Skills

All three skills require LLM reasoning. Deterministic transforms (PDF rendering, Marp rendering, spec file generation) run as CI scripts — no AI involved.

### `/arqqitect:draft [chapter]`

Invoked from within a chapter folder or with a chapter argument. Knows which chapter it is working on and asks structured, chapter-appropriate questions (e.g. `07-security` asks about IAM, data protection, compliance; `04-application` asks about services, APIs, components). After the interview, drafts Markdown files directly into the chapter folder. Architect edits, refines, and commits.

### `/arqqitect:review [chapter | all]`

Reviews one chapter or the entire `docs/` tree. Identifies:
- **Gaps** — content missing from the chapter
- **Inconsistencies** — conflicts between chapters
- **Risks** — decisions that appear underthought

Output is a Markdown report committed to `10-raid/` as an issue entry. Intended to run before a PR is opened so the architect can self-correct before requesting human review.

### `/arqqitect:generate-slides`

Reads all of `docs/` and reasons about narrative: core story, audience, order. Produces a Marp-formatted Markdown file written to `output/slides/`. CI renders it to HTML on merge. Can be re-invoked when the HLD changes significantly.

---

## Outputs

| Output | How produced | Location |
|---|---|---|
| HLD PDF | CI: pandoc on merge to main | `output/pdf/` |
| Slides HTML | CI: Marp on merge to main (after AI writes slide Markdown) | `output/slides/` |
| Engineering specs | CI: `generate-specs.sh` on merge to main | `output/specs/` |

### Engineering Spec Format

Structured Markdown with YAML frontmatter. Human-reviewable in GitHub PRs, machine-parseable by spec-kit.

```markdown
---
id: spec-001
title: User Authentication
status: draft
priority: high
components: [auth-service, user-db]
---

## Problem Statement
...

## Acceptance Criteria
- [ ] ...

## Technical Constraints
...
```

The frontmatter schema is defined by spec-kit. arqqitect's `generate-specs.sh` produces files that conform to it.

---

## End-to-End Workflow

```
1. SETUP
   Fork arqqitect → rename for the engagement (e.g. hld-acme-platform)
   Update CLAUDE.md: client, project, date, scope

2. AUTHORING (repeat per chapter)
   → /arqqitect:draft          interview + draft Markdown into chapter folder
   → Architect edits, commits to feature branch (e.g. draft/07-security)
   → /arqqitect:review         self-review: gaps, inconsistencies, risks → 10-raid/
   → Open PR                   human reviewers comment on GitHub
   → Address comments → merge
   → CI: pandoc → output/pdf/

3. CROSS-CHAPTER REVIEW
   → /arqqitect:review all     full consistency check
   → Fix issues → PR → merge

4. SLIDES
   → /arqqitect:generate-slides   build narrative, write Marp Markdown
   → Commit → CI renders → output/slides/

5. HANDOFF TO ENGINEERING
   → CI runs generate-specs.sh on every merge
   → output/specs/ → spec-kit
```

---

## What is NOT in scope

- spec-kit (separate project, consumes `output/specs/`)
- PDF/slides rendering toolchain setup (pandoc, Marp — documented in README, not implemented here)
- Authentication or access control for the repo (standard GitHub permissions)
