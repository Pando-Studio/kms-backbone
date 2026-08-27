# Project template

Copy this folder to `projects/<your-project>/` to start a new project (or run `/new-project`).

Every project follows the same grammar:

| Folder | Purpose |
|---|---|
| `1.signals/` | Raw inputs: feedback, transcripts, emails, analytics. Date-first naming (`YYYY-MM-DD-topic.md`). |
| `2.intents/` | Formalized decisions and strategy — answers "what?" and "why?". |
| `3.specs/` | Technical specs — answers "how?". Organized by topic, never by phase. |
| `meetings/` | Meeting notes, date-prefixed. |
| `admin/` | Contracts, proposals, legal documents. |
| `comm/` | Communication and go-to-market material. |
| `apps/` | Code, as git submodules. |

Knowledge flows through the pipeline: `1.signals/` → `2.intents/` → `3.specs/`.
APE phases are metadata (YAML frontmatter `phase: X`), never directories.
Effort sizing is S / M / L — never time estimates. Fill unknowns with N/C — never hallucinate.

Replace this README with your project overview: Context, Objectives, Status, Key contacts, Links.
