# Contributing

This repository is governed the way it recommends governing knowledge: every contribution — human or agent — goes through the same gate.

## How to propose a change

1. Fork and branch.
2. Make your change following [docs/conventions.md](docs/conventions.md) (naming, structure, S/M/L sizing, no invented facts — mark missing information `N/C`).
3. Open a pull request. If the change was produced with an AI agent, say so in the PR description — agent contributions are welcome and reviewed identically.
4. Automated checks run (convention lint). A maintainer validates and merges. Every merge is a dated, attributed decision in the history.

## What we're looking for

- Corrections and clarifications to the docs.
- Genericization improvements: anything that makes the backbone easier to instantiate outside its original context.
- Reference implementations for the `spec`-status items in `reference/` (vectorization, MCP configs, sandbox).
- Skill improvements and new generic skills (they must be org-agnostic).

## What we'll decline

- Org-specific or vendor-locked content in `docs/` or `template/` (vendor-specific material belongs in `reference/`, clearly labeled).
- Features that add a dependency to the core: Markdown + Git must remain the whole requirement.

## Pace

The backbone evolves with its maintainers' internal practice; issues and PRs are triaged in batches. Thanks for your patience.
