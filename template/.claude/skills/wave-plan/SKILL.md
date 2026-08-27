Create or update wave planning for a project's stories.

Waves organize tasks into **parallel execution groups** for multi-agent or multi-developer work.

Reference: the KMS Backbone docs (docs/ in the backbone repo) — Define toolkit, Wave planning.

The user will provide:
1. Project path (e.g., `projects/acme-app/`)
2. Optional: specific sub-project or topic

Steps:
1. Read `{project}/3.specs/stories.md` (or stories in relevant location) for the story backlog
2. Read `{project}/3.specs/architecture.md` if it exists (for dependency analysis)
3. Read `{project}/3.specs/glossary.md` for domain terms
4. Analyze dependencies between stories
5. Propose wave assignments

Wave patterns (choose based on context):

| Pattern | When | Sequence |
|---|---|---|
| **Backend-First** | New app, no existing API | DB + Models → API → Frontend → Integration |
| **Parallel API-Frontend** | Shared contracts defined | Contracts → Backend + Frontend parallel → Integration |
| **Feature-Complete** | Existing app, adding feature | Setup → Implementation → Integration |

Process:
1. **Analyze dependencies**: which stories block others?
2. **Identify foundation**: what must exist first (DB schema, auth, shared types)?
3. **Group by layer**: backend, frontend, integration, infra
4. **Create waves**: each wave = stories that can run in parallel
5. **Validate conflicts**: no two stories in the same wave should touch the same files/modules
6. **Assign labels**: for issue-tracker sync

Output format:

```markdown
# Wave Plan — {project name}

## Context
- Pattern: {Backend-First / Parallel / Feature-Complete}
- Total stories: {count}
- Estimated waves: {count}

## Dependencies
{Mermaid dependency graph}

## Wave 0 — Foundation
> Prerequisites that everything depends on.
| Story | Title | Effort | Dependencies | Exclusive scope |
|---|---|---|---|---|
| US-001 | ... | S/M/L | — | {folder or module} |

## Wave 1 — {Theme}
> {What this wave achieves}
| Story | Title | Effort | Dependencies | Exclusive scope |
|---|---|---|---|---|
| US-002 | ... | M | US-001 | {folder or module} |

## Wave N — Integration & Polish
> Cross-cutting: integration tests, edge cases, polish.
| Story | Title | Effort | Dependencies | Exclusive scope |
|---|---|---|---|---|
```

Rules:
- Each story appears in exactly one wave
- Wave 0 = foundation (always first, no parallelism needed)
- Last wave = integration + cross-cutting concerns
- Exclusive scope ensures no merge conflicts in multi-agent work
- Effort sizing: S / M / L only — never time estimates
- Do NOT create the file automatically — present plan and wait for user validation
- Flag any stories with unclear dependencies as blockers
