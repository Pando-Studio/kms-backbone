# KMS Template — Instantiation Guide

This folder is the starting point of your own Knowledge Management System: a Git+Markdown repo where humans and AI agents work under the same conventions. Copy it, rename it, and start capturing knowledge.

## Prerequisites

- Git (that's the only hard requirement)
- Optional but recommended: Claude Code or any agent CLI that reads `CLAUDE.md`-style context files and supports skills/hooks

## Steps

1. **Use the template**: click "Use this template" on the backbone repo (or copy this `template/` folder into a fresh repo).
2. **Rename**: name the repo after your org's KMS (e.g., `acme-kms`).
3. **Set your language policy**: edit `CLAUDE.md` and replace the language policy placeholder (e.g., "English for everything").
4. **Define your sensitivity partition**: decide what is visible to the core team vs the extended circle vs local-only (`private/`). See [../docs/02-governance.md](../docs/02-governance.md) for the governance model.
5. **Wire CI to your git host**: point your CI workflows at `scripts/lint-kms.sh` to lint changed Markdown files on every push/PR.
6. **Create your first project**: copy `projects/_template/` to `projects/<name>/`, or run `/new-project` from your agent CLI.

Then start feeding the pipeline: drop raw material into `1.signals/`, run `/process-signals`, and let decisions accumulate in `2.intents/` and specs in `3.specs/`.

## What to customize

- `CLAUDE.md`: language policy, repo structure block (add top-level areas your org needs, e.g. `ops/` subfolders)
- `infra/`: your org-specific conventions and tooling notes (deltas from the backbone docs, not forks)
- `projects/_template/`: add folders your projects always need (keep the core grammar)
- `.claude/skills/`: add your own skills alongside the 16 ported ones
- Sensitivity partition: which folders are core team only vs extended circle

## What NOT to touch

These are load-bearing — skills, the lint hook, and CI all depend on them:

- **Pipeline numbering**: `1.signals/` → `2.intents/` → `3.specs/` stays numbered exactly like this
- **Project grammar**: the folder set in `projects/_template/` (signals, intents, specs, meetings, admin, comm, apps)
- **Phase-as-metadata**: APE phases live in YAML frontmatter, never as directories
- **Naming rules**: date-first files in `1.signals/` and `meetings/`
- **Sizing rule**: S / M / L, never time estimates
- `private/` stays gitignored and local-only

## Layout

```
CLAUDE.md            # Agent context — read by any agent working in the repo
.claude/             # Skills (16) + lint hook + settings for Claude Code
scripts/lint-kms.sh  # Convention linter (hook + CI entry point)
projects/_template/  # Project grammar — copy per project
infra/               # Your org-specific overrides
```

Full methodology and system docs: the KMS Backbone repo's [../docs/](../docs/).
