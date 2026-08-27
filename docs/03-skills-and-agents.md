# Skills & Agents

## A skill is a reviewed Markdown file

In this system, an agent competency is not a plugin or a fine-tune. It is a **skill**: a Markdown file containing instructions, steps, and an output format, stored in the repository and versioned like every other artifact. A skill is invoked by name (`/process-signals`, `/adr`) inside an agent session.

Because a skill is prose in a file, it goes through the same lifecycle as any document in the KMS: proposed as a pull request, reviewed by a human, merged through a gate (see [04-knowledge-cicd.md](04-knowledge-cicd.md)). **Skills are code-review-able.** When an agent misbehaves, you `git blame` the skill, fix the instruction, and open a PR — the fix is dated, attributed, and shared by every operator from the next pull.

## How agents operate on the KMS

Three rules define the agent's footprint:

1. **Read scope = checkout.** An agent runs inside an operator's working copy and can only read the repositories that operator can clone. There is no separate permission system for AI — see [02-governance.md](02-governance.md).
2. **Write = pull request.** Agents produce artifacts (signal syntheses, intents, specs, ADRs, code) as branches and PRs, never direct commits to protected branches.
3. **Agents never merge.** Every merge is a human decision. The agent proposes; a named person is accountable for what enters the shared memory.

The result: agent output is subject to exactly the same gates as human output, and the audit trail is the git history itself.

## The 16 pipeline skills

The template ships 16 generic skills in `template/.claude/skills/`, one folder per skill, each with a `SKILL.md`. They map to the phase model described in [07-methodology.md](07-methodology.md).

**Setup**
- `new-project` — scaffold a project folder with the standard grammar (`1.signals/`, `2.intents/`, `3.specs/`, `meetings/`, `admin/`).
- `ape-init` — initialize the phase structure and spec templates for a project.

**Discovery**
- `process-signals` — the core pipeline operation: analyze `1.signals/`, extract observation → insight → implication, propose intents.
- `synthesize` — synthesize a folder's contents into themes, patterns, and open questions.
- `meeting-note` — turn a raw transcript into a structured note (decisions, actions) in `meetings/`.
- `deep-research` — structured investigation of a topic with external sources.

**Define**
- `glossary` — build the domain glossary from all project docs (first Define artifact).
- `user-stories` — generate INVEST stories from intents and personas, with acceptance criteria.
- `wave-plan` — organize stories into parallel execution waves with dependencies.

**Deliver**
- `adr` — create an Architecture Decision Record.
- `task-decompose` — break a story into 3–8 implementation tasks with a definition of done.
- `execution-brief` — produce an implementation-ready brief per task (the bridge from specs to code).

**Gates & quality**
- `review` — adversarial review of any document: find gaps, contradictions, missing links.
- `ape-gate` — check a phase gate: verify expected artifacts exist and cohere, output a readiness score.

**Anytime**
- `status` — generate a project status report.
- `index` — regenerate a folder's README/table of contents.

Two additional skills (`sync-issues`, `drive-manifest`) are connectors rather than pipeline operations — see [05-connections.md](05-connections.md).

## Skill anatomy

A `SKILL.md` is short — typically under a page. Generic skeleton:

```markdown
---
name: process-signals
description: Transform raw signals into structured intents.
---

Transform the raw signals of a project into proposed intents.
Reference: docs/01-knowledge-layer.md (pipeline), docs/07-methodology.md (phase toolkit).

The user provides a project path (e.g., `projects/acme-app/`). If missing, ask.

Steps:
1. Read all `.md` files in `{project}/1.signals/`
2. For each signal, extract: type, source, observations, insights, implications
3. Group insights by theme; identify recurring patterns
4. Flag contradictions between signals
5. Propose intent documents to create in `2.intents/`

Output format:
## Themes identified
## Patterns
## Contradictions
## Proposed intents

Rules:
- Never create files without confirmation — propose, then wait
- Write N/C when information is missing — never invent data
```

The recurring structure: **frontmatter** (name, description) → **context and inputs** → **numbered steps** → **explicit output format** → **rules** (the guardrails: confirmation before writing, no invented data, traceability to sources). The rules section is where most review comments land — it encodes the organization's risk posture in plain text.

## Which skill at which pipeline stage

| Stage | Skills | Typical sequence |
|---|---|---|
| Project setup | `new-project`, `ape-init` | create folder → scaffold specs |
| Discovery | `deep-research`, `meeting-note`, `synthesize`, `process-signals` | collect raw material into `1.signals/` → research → synthesize → propose intents → `ape-gate discovery→define` |
| Define | `glossary`, `user-stories`, `wave-plan`, `review` | glossary first → stories from intents → waves → adversarial review → gate → push stories to the board (`sync-issues`) |
| Deliver | `adr`, `task-decompose`, `execution-brief`, `review` | architecture doc → ADRs per decision → review → decompose stories → brief per task → code → gate |
| Deploy and beyond | `review`, `ape-gate`, `status` | review test plan and beta feedback → go/no-go gate |
| Maintenance | `status`, `index` | status on demand; regenerate folder indexes after additions |

Two conventions cut across all of them: skills that write files always **propose first and wait for confirmation** on anything outside a PR flow, and skills that summarize always **cite their source files** so a reviewer can trace every claim.

## Portability

The skills ship in Claude Code format (a `.claude/skills/<name>/SKILL.md` layout with YAML frontmatter), because that is what the template was built with. But a skill is plain Markdown: any agent runtime that can inject a file into context can run them, and adapting the layout to another harness is a rename, not a rewrite. More importantly, the structure works without any of this — the pipeline, gates, and grammar in [00-concept.md](00-concept.md) and [conventions.md](conventions.md) are usable by humans alone; skills automate the workflow, they do not define it.
