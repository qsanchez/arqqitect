# arqqitect

Architecture documentation as code. AI-assisted authoring, human review via pull requests, generated outputs (PDF, slides, engineering specs).

## Prerequisites

- [Claude Code](https://claude.ai/code)
- [GitHub CLI](https://cli.github.com/) (`gh`)
- A GitHub account

## Start a new engagement

**1. Fork this template**

```bash
gh repo create my-engagement-hld \
  --template qsanchez/arqqitect \
  --private \
  --clone
cd my-engagement-hld
```

**2. Open in Claude Code and fill in engagement metadata**

Edit `CLAUDE.md` — replace the placeholder values (project name, client, scope).

**3. Start drafting**

```
/draft 01-context
```

Claude will ask you questions about the business context and draft `docs/01-context/` for you.
Repeat for each chapter you want to cover.

## Authoring workflow

```
/draft [chapter]          Interview + draft a chapter
/review [chapter | all]   Review content: gaps, inconsistencies, risks
/generate-slides          Build a Marp slide deck from all docs/
```

After drafting a chapter:

1. Review and edit the generated Markdown files
2. Run `/review [chapter]` — findings go to `docs/10-raid/issues.md`
3. `git checkout -b draft/[chapter]`
4. Open a PR — use the PR template checklist to guide reviewers

## CI outputs

On every merge to `main`:

| Trigger | Output | Location |
|---|---|---|
| `docs/**` changes | PDF rendered by pandoc | GitHub Actions artifact |
| `output/slides/*.md` changes | Slides rendered by Marp | GitHub Actions artifact |
| `docs/**/*-spec.md` changes | Engineering specs collected | GitHub Actions artifact |

Download artifacts from the **Actions** tab in GitHub.

## Engineering specs

To hand off work to engineering, create a `<component>-spec.md` file in the relevant chapter folder.
See the spec file format in `CLAUDE.md`. CI collects all `*-spec.md` files into `output/specs/`.

## Toolchain

PDF rendering requires pandoc and xelatex (installed by CI). To render locally:

```bash
sudo apt-get install pandoc texlive-xetex
find docs -name "*.md" | sort | xargs pandoc -o output/pdf/hld.pdf --pdf-engine=xelatex --toc
```

Slides rendering requires Marp CLI. To render locally:

```bash
npm install -g @marp-team/marp-cli
marp output/slides/slides.md --html
```
