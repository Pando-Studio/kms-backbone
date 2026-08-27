# Conventions

> Quick-reference rules for daily work in the knowledge repo. For the reasoning behind them, see [01-knowledge-layer.md](01-knowledge-layer.md) (structure and storage), [02-governance.md](02-governance.md) (access and sensitivity), and [07-methodology.md](07-methodology.md) (phases and gates).

These are the conventions one reference implementation converged on. Adopt them as-is or adapt — what matters is that your organization picks *one* answer per question and writes it down, because agents and humans both rely on the rules being stable.

---

## File naming

Three modes, chosen by whether order matters and what kind of order:

| Mode | When | Format | Example |
|---|---|---|---|
| **Date-first** | Chronological order matters | `YYYYMMDD-{topic}.md` or `YYYY-MM-DD-{topic}.md` | `20260306-feedback-quiz.md` |
| **Number-first** | Logical order matters | `NN-{topic}.md` | `01-product-vision.md` |
| **Name-only** | Living document, updated in place | `{topic}.md` | `architecture.md` |

Pick **one** date-prefix format (`YYYYMMDD-` or `YYYY-MM-DD-`) and use it everywhere — both sort correctly; mixing them doesn't.

Per-directory defaults:

| Folder | Mode |
|---|---|
| `1.signals/` | Always date-first |
| `meetings/` | Always date-first |
| `2.intents/` | Mixed: date-first for punctual decisions, number-first for structured sequences, name-only for living docs |
| `3.specs/` | Generally name-only; number-first if sequence matters |
| `admin/` | Date-first or number-first |
| `comm/` | Name-only |

**Numeric prefixes on folders** encode priority or reading order (`1.signals/`, `2.intents/`, `3.specs/`; optionally on root folders). Use them only where order carries meaning — a prefix that means nothing is noise.

---

## Dates

- **ISO everywhere**: `YYYY-MM-DD` for exact dates, `YYYY-MM` when only the month is relevant.
- Applies to filenames **and** document metadata headers (e.g. `**Date**: 2026-03`).
- Never use text dates ("March 2026", "early Q2") in filenames or metadata — they don't sort and don't parse.

---

## Effort sizing: S / M / L only

- **S** = small, contained change
- **M** = moderate, multi-step work
- **L** = large, cross-cutting effort

Never time estimates ("2 weeks", "3 days") in specs, epics, readiness checks, or project docs. Letter sizes survive re-planning and team changes; dates baked into documents rot immediately and get quoted as commitments. Scheduling belongs in your issue tracker, not in the knowledge base.

---

## Writing rules

- **No invention — `N/C` when missing.** If information is not provided, write `N/C` (not communicated). Never fill a gap with a plausible guess. This is the load-bearing rule for a corpus that agents read and write: one hallucinated "fact" propagates through every synthesis downstream.
- **No code examples in architecture or specs.** Stay at the level of components, contracts, and decisions. Code lives in the app repositories; the moment a spec contains code, the two diverge silently.
- **Don't overwrite specs.** Extend, supersede with a dated decision entry, or archive — but a spec someone relied on shouldn't change meaning under their feet.
- **Never duplicate between levels.** Project knowledge (`3.specs/`) holds architecture and decisions; app repos (`apps/*/docs/`) hold setup, API reference, changelogs, dev logs. Each side links to the other instead of copying.
- **Macro planning only.** No detailed task planning inside knowledge docs — a macro roadmap at architecture level is fine; task breakdowns belong in the issue tracker.
- **Decision log per topic.** Each `3.specs/{topic}/` maintains a `decisions.md`: a chronological table of product and technical decisions (scope changes, tech picks, phase boundaries). Lighter than an ADR, heavier than nothing.
- **Ask rather than assume.** When a source document is ambiguous, ask the owner (or flag the ambiguity in the output) instead of resolving it silently.

---

## Language policy

For organizations working across languages, set an explicit split rather than leaving it to each author. The reference rule:

- **English** for everything engineering-facing: specs, architecture, ADRs, technical docs.
- **Local language or English** for business content: strategy, admin, meeting notes, client-facing material.

Rationale: engineering artifacts are read by tooling, agents, and potentially external contributors — one language keeps them uniform. Business content optimizes for its human audience. Whatever split you choose, record it here so agents generate content in the right language per directory.

---

## Structure rules (summary)

Full detail in [01-knowledge-layer.md](01-knowledge-layer.md); the invariants:

- Pipeline: `1.signals/` (raw) → `2.intents/` (what/why) → `3.specs/` (how).
- Decision rule: "what/why?" → `2.intents/` | "how?" → `3.specs/`.
- Phases are **metadata** (YAML frontmatter, else pipeline convention: `1.signals/` → discovery, `2.intents/` → define, `3.specs/` → deliver) — never directories.
- `3.specs/` is organized by topic or sub-project, never by phase.
- Inside `3.specs/{topic}/`: root = meta docs (`README.md`, `overview.md`, `glossary.md`, `decisions.md`), subdirs = concerns (`architecture/`, `database/`, `features/`).
- Every active project keeps a `1.signals/` inbox of material to process and classify.

---

## Storage rules (summary)

Full detail in [01-knowledge-layer.md](01-knowledge-layer.md) §6; the invariants:

- `.md` → git (source of truth). Binaries (PDF, images, media, CSV > 1 MB) → cloud storage, gitignored, listed in a versioned manifest file.
- Code → git submodules under `apps/`; never mirrored to cloud storage.
- `private/` → strictly local: gitignored, never uploaded, never published.
- Binary uploads are explicit one-shot actions, not background daemon sync. If you do run a live sync daemon on the working copy, never switch git branches while it runs.
- Merge via pull request on your git host, then pull locally — avoid local branch merges.

---

## External tools

- If you publish the repo to an internal wiki or dashboard, treat it as a **derived, read-only view** — git remains the source of truth, and excluded paths (code, config, `.github/`) should not be rendered.
- Link knowledge documents to their corresponding issue-tracker items (GitHub Issues, Linear, Jira) when relevant, and keep the two in sync deliberately — see [05-connections.md](05-connections.md).
- Agent-facing context files (`CLAUDE.md`, `AGENTS.md`, skill definitions) follow the same conventions as everything else; see [03-skills-and-agents.md](03-skills-and-agents.md) and [06-tooling-and-sandbox.md](06-tooling-and-sandbox.md).
