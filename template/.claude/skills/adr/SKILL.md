Create an Architecture Decision Record (ADR).

Reference: the KMS Backbone docs (docs/ in the backbone repo) — Deliver toolkit, ADRs.

The user will provide:
1. Project path (e.g., `projects/acme-app/`)
2. The decision topic (e.g., "use a managed auth provider", "event-driven vs REST")

Steps:
1. Read `{project}/3.specs/architecture.md` for existing architecture context
2. Read existing ADRs in `{project}/3.specs/adr/` to check for conflicts or superseded decisions
3. Read `{project}/3.specs/glossary.md` for domain terms
4. Read relevant intents in `{project}/2.intents/` for the business context behind the decision
5. Draft the ADR

ADR template:

```markdown
# ADR-{NNN}: {Decision Title}

## Status
Proposed

## Date
{YYYY-MM-DD}

## Context
{Background forces driving this decision. What problem are we solving?
Reference the upstream intent or story that motivates this choice.}

## Decision
{The change being made. Be specific and unambiguous.
Use glossary terms.}

## Alternatives considered

### {Alternative A}
- **Pros**: ...
- **Cons**: ...
- **Rejected because**: ...

### {Alternative B}
- **Pros**: ...
- **Cons**: ...
- **Rejected because**: ...

## Consequences

### Positive
- {what improves}

### Negative
- {what gets harder, new constraints introduced}

### Neutral
- {side effects, things that change but neither improve nor worsen}

## References
- {link to intent, story, or external resource}
```

Numbering:
- Check existing ADRs in `{project}/3.specs/adr/` and increment
- Format: `ADR-001`, `ADR-002`, etc.
- Filename: `adr-{NNN}-{short-slug}.md` (e.g., `adr-001-auth-provider.md`)

Rules:
- An ADR is **immutable once accepted**. To change a decision, create a new ADR that supersedes the old one (update old ADR status to "Superseded by ADR-NNN")
- Every ADR must trace to an upstream intent or story
- Use glossary terms — flag any term not in the glossary
- Stay high level — no code examples (per guidelines)
- Present the draft and wait for user validation before writing
- Create the `adr/` directory inside `3.specs/` if it doesn't exist
