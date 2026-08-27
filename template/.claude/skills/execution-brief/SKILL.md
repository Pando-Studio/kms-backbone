Generate an execution brief for a development task.

An execution brief is an **implementation-ready prompt** that bridges specs and code. It gives an AI agent (or developer) everything needed to implement a task without ambiguity.

Reference: the KMS Backbone docs (docs/ in the backbone repo) — Deliver toolkit, Execution briefs.

The user will provide:
1. Project path
2. Task reference (story ID, task file, or description)

Steps:
1. Read the task definition (from `3.specs/tasks.md`, `3.specs/tasks/`, or user input)
2. Read the parent story and its acceptance criteria (from `3.specs/stories.md` or `3.specs/stories/`)
3. Read the architecture doc (`3.specs/architecture.md`) for patterns and constraints
4. Read relevant ADRs in `3.specs/adr/`
5. If code exists in `apps/`, inspect the relevant files
6. Read the glossary (`3.specs/glossary.md`) for domain terms

Generate:

```markdown
# Execution Brief: {Task ID} — {Task Title}

## Objective
{Single-sentence implementation goal}

## Context
{Why this task exists, what story it belongs to, what user need it serves}

## Constraints
- Technical: {patterns, framework, conventions from architecture.md}
- Business: {rules from glossary, acceptance criteria}

## Architecture points
- {Relevant patterns to follow from architecture.md and ADRs}

## Files to inspect
- {List of existing files to read before starting}

## Expected changes
- {What files to create/modify, what the output should look like}

## Acceptance criteria
{Copy from story, in Given/When/Then format}

## Validation
- {Commands to run: tests, lint, build}

## Stop conditions
{When to stop and ask a human: ambiguity, missing info, architecture decision needed}

## Non-goals
{What this task explicitly does NOT do}
```

Rules:
- The brief must be **self-contained** — an agent should be able to implement without reading other docs
- Include concrete file paths, not abstract descriptions
- Include the exact acceptance criteria from the story
- Flag any ambiguity or missing information as blockers
- Save the brief in `3.specs/tasks/` alongside the task
