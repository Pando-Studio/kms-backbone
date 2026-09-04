# Ontology profile: Acme Studio (filled example)

> The audit output for **Acme Studio**, the fictional 8-person digital agency of `acme-project/`.
> This is what the deliverable of `ontology/audit-kit.md` looks like once filled: compare with the
> blank template in `template/infra/ontology/profile.md`. Everything here is invented for illustration.

## Modules

| Module (folder) | Business function | Sensitivity tier | Access population |
|---|---|---|---|
| `pipeline/` | Pre-sale: prospects, proposals, follow-ups | team | sales duo (2) |
| `projects/` | Client engagements (like `acme-project/`) | team | whole studio |
| `catalogue/` | Offers and pricing: the source of truth quoted in proposals | team | whole studio |
| `org/` | Legal, finance, HR | restricted | founders (2) |

Audit note: `pipeline/` and `org/` have genuinely distinct access populations today, so they are the two submodule candidates. `catalogue/` stays a plain folder: everyone reads it.

## Entity types

| Type | Lives in | Required frontmatter | Status enum (team's words) |
|---|---|---|---|
| `prospect` | `pipeline/` | status, owner, created, next_action, next_action_date, estimated_value | new → contacted → meeting → proposal → won / lost |
| `project` | `projects/` | type, phase, status, client, team | per methodology phases (see docs/07) |
| `offer` | `catalogue/` | status, price_range, effort | draft → active → retired |
| `grant_file` | `org/` | status, funder, deadline | identified → drafting → submitted → accepted / rejected |

Audit note: the team said "piste" for early prospects and "affaire" after the first meeting; the audit kept ONE type (`prospect`) with those words inside the enum rather than two types, per the over-typing anti-pattern.

## Relations

| From | To | Meaning |
|---|---|---|
| `prospect` | `project` | a won prospect becomes a project (the fiche stays in `pipeline/`, status `won`, linked) |
| `project` | `offer` | a project references the offers it was sold from |

## Fast-lane whitelist

- status
- next_action
- next_action_date
- relance_count

## Rhythms

| Job | Cadence | Output |
|---|---|---|
| Pipeline digest (overdue next actions, dormant deals) | weekdays, morning | team channel |
| Follow-up drafts (never auto-sent) | daily | drafts for human review |
| Weekly pipeline report | Monday morning | team channel |

## Templates

Proposal skeleton, meeting note, monthly client report (harvested during the audit from the three most-reused documents).

## External taxonomies

| Taxonomy | Source | Applies to |
|---|---|---|
| N/C: none found | N/C | N/C |

Audit note: no regulator-imposed vocabulary for this agency; the field stays N/C rather than inventing one.
