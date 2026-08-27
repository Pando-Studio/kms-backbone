# 07 — The Reference Methodology: APE

The backbone does not impose a process. It carries a product lifecycle as **metadata**: every artifact declares (or implies, via its pipeline location) which phase of the lifecycle it belongs to, and phase transitions are marked by **gate artifacts** merged through pull requests. This document describes the reference methodology those hooks were designed for — **APE (Adaptive Product Engineering)**, an 8-phase cycle for building products with mixed human-AI teams.

You can adopt APE as-is, trim it, or replace it with your own phase model. What must survive any replacement are the structural hooks:

- **Phase frontmatter** — artifacts carry a `phase:` key, or inherit a phase from their pipeline folder (see [01-knowledge-layer.md](01-knowledge-layer.md), "Phase as metadata").
- **Gates** — phase transitions are recorded as dated, human-approved artifacts merged through the same PR loop as everything else (see [02-governance.md](02-governance.md)).

Tooling (dashboards, agents, skills — see [03-skills-and-agents.md](03-skills-and-agents.md)) reads these hooks, not the methodology's name.

## The eight phases

```
Pre-sale → Discovery → Define → Deliver → Deploy → Communicate → Support → Iterate
                ↑ ______________________________________________________ ↓
                                    (feedback loop)
```

| # | Phase | Objective | Key artifacts (pipeline location) | Exit gate |
|---|---|---|---|---|
| 0 | **Pre-sale** | Qualify the opportunity, scope it, propose | Brief, proposal, quote (`admin/`, signals in `1.signals/`) | Engagement Accepted — contract signed |
| 1 | **Discovery** | Understand the problem, users, market | Interview notes and research inputs (`1.signals/`), research report, personas, problem statement (`2.intents/`) | Research Review |
| 2 | **Define** | Decide what to build | Scope and priorities (`2.intents/`), glossary, user flows, stories, wave plan (`3.specs/`) | MLP Vote — ≥70% stakeholder consensus on scope |
| 3 | **Deliver** | Architect, implement, test | Architecture, ADRs, decision log, task breakdown (`3.specs/`), code (`apps/`) | Readiness Gate (specs complete) then Staging Review (code works in staging) |
| 4 | **Deploy** | Ship progressively: staging → beta → production | Test strategy, beta feedback, monitoring setup (`3.specs/`, feedback in `1.signals/`) | Go/No-Go |
| 5 | **Communicate** | Launch, train, announce | Launch plan, messaging (`comm/`) | Launch executed |
| 6 | **Support** | Monitor adoption, handle support | Support playbook, metrics (`3.specs/`, tickets and NPS in `1.signals/`) | Support processes established |
| 7 | **Iterate** | Measure, learn, decide the next cycle | Retrospective, KPI review, next-cycle brief (`2.intents/`) | Backlog prioritized — pivot or persevere |

Iterate feeds back into Discovery: each cycle starts from validated outcomes, not assumptions. Not every piece of work runs the full cycle — a well-understood feature can run Discovery → Deploy, and a bug fix takes a quick path (spec, dev, test). When in doubt, default one level heavier.

Note the pattern in the artifact column: raw inputs land in `1.signals/`, decisions in `2.intents/`, technical specifications in `3.specs/` — the phases ride on top of the knowledge pipeline described in [01-knowledge-layer.md](01-knowledge-layer.md); they never create their own directory structure.

## Gates

A gate is a phase transition, not a status meeting. Each gate checks one specific risk before the organization escalates its level of commitment:

| Gate | Between | What it checks |
|---|---|---|
| MLP Vote | Discovery → Define | Are we solving the right problem? (solution accuracy) |
| Readiness | Define → Deliver | Is the spec complete enough to build from? |
| Go/No-Go | Deliver → Deploy | Is the implementation correct? (tests pass, staging stable, no critical issues) |
| Beta Validation | Deploy → Communicate | Both accuracies, before public exposure |

Three properties define how gates work in the backbone:

- **Humans vote; agents never do.** A gate decision is made by named humans — a stakeholder vote (MLP Vote uses anonymous scoring with a 70% consensus threshold), an architecture review, a Go/No-Go call. AI can prepare the checklist and flag gaps; it cannot pass the gate.
- **The decision is an artifact.** Passing a gate produces a dated markdown record (e.g. `2.intents/decisions/2026-03-14-mlp-vote.md` in `acme-billing/`) stating what was decided, by whom, and what was explicitly excluded. It merges through a pull request like any other contribution, so `git log` is the audit trail of every phase transition — the same mechanism that governs all knowledge in [02-governance.md](02-governance.md).
- **Critical gates are adversarial.** At Readiness and Go/No-Go, the review's goal is to find what is missing or wrong, not to confirm readiness. A defect caught in staging costs an order of magnitude less than one caught in production; gates add hours upstream to save days downstream.

## RACI: AI produces, humans decide

The division of labor is constant across all eight phases: **agents are Responsible for production, humans are Accountable for decisions — an agent is never Accountable for anything.** AI drafts the research synthesis, the stories, the architecture diagrams, the code, the tests; a human validates each of them at the gate. Where the work is inherently relational — user interviews, launch strategy, customer relationships — humans are Responsible too and AI drops to Consulted. The practical consequence: every artifact an agent produces flows through a human-approved PR before it becomes part of the record.

## TTAF — Time To Accurate Feature

Most teams measure commit-to-deploy lead time. That window misses both ends of the loop: the time a user need spends waiting to become an actionable story, and the time between "deployed" and "confirmed to actually work and matter." TTAF measures the full span:

> **TTAF is the time from a formalized business signal to a validated, accurate feature in production.**

"Accurate" means two things, and both are required:

1. **Implementation accuracy** — built correctly: tests pass, and no rollback or critical hotfix occurs within an observation window (default: 7 days after production deploy).
2. **Solution accuracy** — built the right thing: the feature is adopted and measurably addresses the problem the signal described.

### Decomposition

| Metric | Start | End |
|---|---|---|
| **TTS** (Time To Story) | Signal formalized in `1.signals/` | Story accepted for build |
| **TTAF-tech** | Story accepted | Production stable — observation window elapsed with no rollback |
| **TTAF-biz** | Story accepted | Business impact validated (adoption, retention, feedback) |
| **TTAF-total** | Signal formalized | Impact validated |

TTS captures upstream latency that lead-time metrics ignore; TTAF-biz captures downstream validation they stop short of. TTAF-biz can stay open for weeks — that is censored data, not failure: a feature without business validation is *not yet measured*, not wrong.

### Instrumenting from git history

Because every step of the lifecycle produces an artifact merged through a PR, the git history already contains the event stream — no separate tracking system is required to start. The events, in order:

`signal_received` → `story_accepted` → `in_dev` → `pr_opened` → `pr_merged` → `ci_passed` → `staging_deployed` → `staging_validated` → `prod_deployed` → `ttaf_tech_validated` → `ttaf_biz_validated` — plus `rollback` and `hotfix` when they occur, which reset the observation window.

Each event maps to an observable git or CI fact: the merge commit that added the signal file to `1.signals/`, the acceptance of the story (issue-tracker transition or merged intent), branch creation, PR lifecycle, deploy workflow runs, and the dated gate artifacts for the validation events. TTAF metrics are then differences between event timestamps — computed, never hand-maintained. Alongside speed, track quality counters per feature (rework PRs after merge, rollbacks, hotfixes within the window, adoption rate) so that a falling TTAF cannot hide a rising defect rate.

## Two conventions that keep the methodology honest

- **Effort is S / M / L — never time estimates.** Sizing communicates relative weight for prioritization; TTAF measures actual elapsed time. Mixing the two turns estimates into commitments and corrupts both signals. See [conventions.md](conventions.md).
- **Phase is metadata, never directory structure.** There is no `3.specs/deliver/` folder. Phase is declared in frontmatter or inferred from pipeline location (`1.signals/` → discovery, `2.intents/` → define, `3.specs/` → deliver). This is what lets you rename, reorder, or replace phases without restructuring the repository — the methodology is swappable precisely because it lives in metadata.
