# arqqitect: Generate Slides

Read all content in `docs/` and produce a Marp-formatted slide deck in `output/slides/slides.md`.

## Step 1 — Read the full HLD

Read all Markdown files in `docs/` (all chapters). Build a mental model of:
- The core story: what problem, what solution, why this approach
- The key architectural decisions and their rationale
- The main components and how they fit together
- The risks and how they are mitigated

## Step 2 — Determine the audience

Check `$ARGUMENTS` for an audience hint:
- `executive` — focus on business value, risks, costs; minimal technical detail
- `technical` — focus on architecture, components, decisions, integrations
- `security` — focus on security architecture, controls, compliance
- If no argument, default to `technical`

## Step 3 — Plan the narrative

Before writing slides, plan the story arc:
1. Context and problem statement (why)
2. Solution overview (what)
3. Architecture (how — adjust depth to audience)
4. Key decisions and trade-offs
5. Risks and mitigations
6. Next steps

Aim for 20–35 slides. Fewer is better — each slide should make one clear point.

## Step 4 — Write the Marp slide deck

Write a Marp-formatted Markdown file to `output/slides/slides.md`.

Marp format rules:
- Start with the YAML frontmatter block
- Separate slides with `---`
- Use `# ` for slide titles
- Keep text minimal — diagrams and bullet points, not paragraphs
- Embed Mermaid diagrams directly in slides where useful

Example structure:

```
---
marp: true
theme: default
paginate: true
---

# [Project Name]
## High Level Design

[Client] | [Date]

---

# Agenda

- Context
- Solution Overview
- Architecture
- Key Decisions
- Risks
- Next Steps

---

# [Next slide title]

[Content]
```

## Step 5 — Confirm

Tell the architect: "Slide deck written to `output/slides/slides.md` — [N] slides.
Review the file, make edits, then commit. CI will render it to HTML on merge to main.
To re-generate, run `/generate-slides [executive|technical|security]`."
