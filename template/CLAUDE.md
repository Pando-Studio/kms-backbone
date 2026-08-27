# KMS — Agent Context

This repository is a **Knowledge Management System (KMS)** for a hybrid human-AI organization. All knowledge lives as Markdown, versioned in Git. Agents and humans work on the same files, under the same conventions. This file is the entry point for any AI agent operating in this repo: read it fully, then follow the conventions below. For the full methodology, see the KMS Backbone docs (docs/ in the backbone repo).

## Key conventions

- **Knowledge pipeline**: `1.signals/` (raw inputs) → `2.intents/` (decisions) → `3.specs/` (technical specs)
- **Decision rule**: "what/why?" → `2.intents/` | "how?" → `3.specs/`
- **Phase as metadata**: APE phases (pre_sale, discovery, define, deliver, deploy, communicate, support, iterate) are NOT directories. They are metadata detected by: (1) YAML frontmatter (`phase: X`), (2) pipeline convention (`1.signals/` → discovery, `2.intents/` → define, `3.specs/` → deliver)
- **Effort sizing**: S / M / L only — never time estimates
- **File naming**: date-first (`YYYY-MM-DD-topic.md`) in `1.signals/` and `meetings/`, name-only for living docs
- **Fill with N/C** when information is not provided — never hallucinate
- **No code examples** in architecture docs or specs — stay high level
- **Language policy**: {SET YOUR POLICY — e.g., "English for everything" or "English for dev/specs, <local language> OK for business content"}

## Repository structure

```
<your-kms>/
├── projects/           # All projects (clients, products, prospects, internal)
│   └── _template/      # Project grammar template — copy to start a project
├── research/           # Research & long-term investigation topics
├── infra/              # System docs overrides + tooling
├── ops/                # Operations (admin, finance, legal, HR)
├── _archive/           # Archived obsolete content
└── private/            # Local only (gitignored) — never committed
```

## Project grammar

Every project follows the same structure:

```
projects/<project>/
├── 1.signals/     # Raw inputs (feedback, transcripts, emails)
├── 2.intents/     # Decisions and strategy
├── 3.specs/       # Technical specs (organized by topic, not by phase)
├── apps/          # Code (git submodules)
├── meetings/      # Meeting notes (date-prefixed)
├── admin/         # Contracts, proposals, legal
└── comm/          # Communication, go-to-market
```

## APE phases (quick reference)

Pre-sale → Discovery → Define → Deliver → Deploy → Communicate → Support → Iterate

| Phase | Objective | Key gate |
|---|---|---|
| Pre-sale | Qualify opportunity, propose | Engagement Accepted |
| Discovery | Understand problem & users | Research Review |
| Define | Decide what to build | MLP Vote (70% consensus) |
| Deliver | Architect + implement + test | Readiness Gate + Staging Review |
| Deploy | Ship to production (beta → prod) | Go/No-Go |
| Communicate | Launch & announce | Launch executed |
| Support | Monitor & support | Processes established |
| Iterate | Measure, learn, decide next | Backlog prioritized |

## Available skills

Use `/skill-name` to invoke.

| Skill | Phase/Use | What it does |
|---|---|---|
| `/new-project` | Setup | Create a project with the standard grammar |
| `/ape-init` | Setup | Scaffold the APE specs structure |
| `/deep-research` | Discovery | Deep investigation on a topic (parallel agent teams) |
| `/meeting-note` | Any | Structure raw notes into a meeting note |
| `/synthesize` | Discovery | Synthesize folder contents into themes |
| `/process-signals` | Discovery→Define | Transform signals into structured intents (core pipeline op) |
| `/glossary` | Define | Build/update a domain glossary from project docs |
| `/user-stories` | Define | Generate user stories from intents and personas (INVEST format) |
| `/wave-plan` | Define | Organize stories into parallel execution waves |
| `/adr` | Deliver | Create an Architecture Decision Record |
| `/task-decompose` | Deliver | Decompose stories into tasks (1 story = 3-8 tasks) |
| `/execution-brief` | Deliver | Generate an implementation-ready brief for a task |
| `/review` | Any gate | Adversarial review of a document (find gaps, contradictions) |
| `/ape-gate` | Any gate | Check phase gate readiness (checklist + score) |
| `/status` | Any | Generate a project status report |
| `/index` | Any | Regenerate a folder index |

## Storage rules

- `.md` files → Git (optionally mirrored to your cloud storage)
- Binaries (PDF, images, decks) → cloud storage only, referenced from Markdown
- Code → Git only, as submodules under each project's `apps/`
- `private/` → strictly local, gitignored — never committed, never synced
