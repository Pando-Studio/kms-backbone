Generate a status report for a project.

Reference: the KMS Backbone docs (docs/ in the backbone repo) — phases and project grammar.

The user will provide a project path (e.g., `projects/acme-travel/`, `projects/acme-app/`). If not provided, ask for it.

Steps:
1. Read the project's README.md and key documents
2. Check the knowledge pipeline: what's in `1.signals/`, `2.intents/`, `3.specs/`?
3. Assess which APE phase the project is in (check YAML frontmatter or pipeline convention)
4. If an issue-tracker MCP is available, pull open issues and recent activity
5. Check recent git activity in the project folder (`git log` for recent commits)

Produce a status report:

```markdown
# Status — {project name} — {today's date}

## Current phase
{APE phase if applicable, or general status}

## Recent activity
{last 5-10 changes in the folder, summarized}

## Open items
{from the issue tracker if available, or from documents}

## Blockers
{anything blocking progress}

## Next steps
{recommended actions}
```

Output directly in the conversation. Keep it concise (1 page max).
