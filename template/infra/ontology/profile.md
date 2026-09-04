# Ontology profile: <organization name>

> Output of the ontology audit (see `ontology/audit-kit.md` in the backbone repo).
> This file declares WHAT your organization's KMS contains; the kernel defines HOW it behaves.
> Changing this file is a PR like any other: your structure gets an audit trail like your content.
> Filled example: `examples/acme-profile.md` in the backbone repo.

## Modules

One row per root folder. Names in YOUR organization's language. Sensitivity is declared from day one; the split into sub-repositories happens only when a second real access population exists.

| Module (folder) | Business function | Sensitivity tier | Access population |
|---|---|---|---|
| `<module>/` | <what it holds> | team \| restricted \| public-ish | <who> |

## Entity types

One row per dossier/document type. The contract lists required frontmatter fields; enums use the team's exact words (an unrecognized vocabulary is wrong, even if logical).

| Type | Lives in | Required frontmatter | Status enum (team's words) |
|---|---|---|---|
| `<type>` | `<module>/` | status, owner, created, next_action, next_action_date | <state1> → <state2> → … |

## Relations

| From | To | Meaning |
|---|---|---|
| `<type>` | `<type>` | <e.g. "won deal becomes project"> |

## Fast-lane whitelist

Frontmatter fields agents may update through auto-merged commits (plus one journal append line). Everything else keeps the full PR gate. Widening this list is a reviewed decision.

- status
- next_action
- next_action_date

## Rhythms

| Job | Cadence | Output |
|---|---|---|
| <digest, follow-up drafts, syncs…> | <cron> | <where it lands> |

## Templates

Reusable document models harvested during the audit (proposal, meeting note, report…), stored next to their entity type.

## External taxonomies

Vocabularies imposed from outside (regulator, certifier, funder): record them as non-negotiable enums with their source.

| Taxonomy | Source | Applies to |
|---|---|---|
| N/C | N/C | N/C |
