# Ontology profiles

A **profile** is the output of the [audit](audit-kit.md): the declarative description of one organization type, which the kernel instantiates into a tree. This page defines what a profile declares and sketches three worked examples. Profiles are Markdown/YAML like everything else: changing a profile is a PR, so the organization's structure has an audit trail like its content.

## What a profile declares

| Field | Content | Example |
|---|---|---|
| `modules` | The root folders: business functions in the org's language, each with a sensitivity tier | `pipeline (team)`, `finance (restricted)` |
| `entity_types` | The dossier/document types in use, each with a frontmatter contract (required fields, enums) | `deal: {status: [new, qualified, proposal, won, lost], owner, next_action_date}` |
| `vocabularies` | The house enumerations: statuses, phases, tiers, categories, in the team's exact words | `mission_status: [pressenti, cadré, en cours, clos]` |
| `relations` | Which typed links exist between entities | `deal → project (won becomes)`, `mission → client` |
| `fast_lane` | The whitelist of frontmatter fields agents may update via auto-merged commits | `status, next_action, next_action_date` |
| `rhythms` | The recurring jobs (digests, follow-up drafts, syncs) and their cadence | `pipeline digest: weekdays 08:30` |
| `templates` | The reusable document models harvested during the audit | proposal, meeting note, report |

Everything else (the pipeline `1.signals/ → 2.intents/ → 3.specs/`, the PR gate, journals, naming rules) is **kernel**: profiles never redefine it.

## Sketch 1 · Studio / agency (consulting, services)

| | |
|---|---|
| Modules | `pipeline` (pre-sale: prospects, proposals), `projects` (client engagements), `catalogue` (offers, the source of truth for pricing), `interventions` (talks, trainings), `org` (admin, legal, finance: restricted tier) |
| Key entity types | `prospect` (status: new → qualified → meeting → proposal → negotiation → won/lost; journal mandatory), `project` (full grammar + `apps/` submodules), `offer` (catalogue fiche with pricing contract), `intervention` |
| Typical vocabularies | deal stages above; effort sizing S/M/L; follow-up cadence (e.g. J+2/J+7/J+14) |
| Typical fast-lane | `status`, `next_action`, `next_action_date`, `relance_count` |
| Access reality | often TWO populations early (sales vs delivery vs corporate): `pipeline` and `org` are the first submodule candidates |

## Sketch 2 · Research lab / PhD track

| | |
|---|---|
| Modules | `thesis` (hub: articles, publication strategy, correspondence), `topics` (research subjects, one dossier each), `foundations` (external references, read papers), `ip` (patents, envelopes: restricted tier), `admin` (funding, legal, calendar) |
| Key entity types | `topic` (status: exploring → active → publishing → dormant), `article` (engagement levels: draft → submitted → published = irreversible), `patent` (gates aligned on filing steps), `reference` (external paper with reading status) |
| Typical vocabularies | publication venues, submission states, funding programs |
| Typical fast-lane | `status`, `deadline`, `submission_state` |
| Access reality | IP module restricted from day one; the rest usually single-population |

## Sketch 3 · School / training organization

| | |
|---|---|
| Modules | `courses` (referentials, syllabi: the reusable capital), `sessions` (one dossier per cohort/session: the lifecycle), `learners` (restricted tier: personal data policy applies), `partners` (funding bodies, certifiers), `org` (admin, compliance) |
| Key entity types | `course` (living doc, versioned syllabus), `session` (status: planned → open → running → evaluated → closed; journal of incidents), `partner_dossier` (certification/funding files with imposed external taxonomies) |
| Typical vocabularies | certification vocabularies are often IMPOSED (regulator, funder): the profile records them as external, non-negotiable enums |
| Typical fast-lane | `session.status`, `enrollment_count`, `next_action_date` |
| Access reality | learner data forces an early restricted partition; keep personal data minimal in git and reference the system of record instead |

## Composition

A multi-activity organization composes profiles in one repository: a studio that also runs a research track activates both sketch 1 and sketch 2 modules; the manifest declares which module belongs to which profile. Composition is normal, not an edge case: most real organizations are at least two of these at once.
