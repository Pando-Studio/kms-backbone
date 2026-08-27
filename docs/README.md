# Docs

Documentation for KMS Backbone: a Git+Markdown knowledge management system for hybrid human-AI organizations.

## Recommended reading order

1. [00-concept.md](00-concept.md) — the problem and the four bricks
2. [01-knowledge-layer.md](01-knowledge-layer.md) — the repository grammar
3. [02-governance.md](02-governance.md) — access and validation
4. [conventions.md](conventions.md) — the rules everything else checks against

Read the others when you need them.

## Index

| Doc | Question it answers |
|---|---|
| [00-concept.md](00-concept.md) | Why this system exists, and what its four core mechanisms are |
| [01-knowledge-layer.md](01-knowledge-layer.md) | How knowledge is structured: monorepo layout, project grammar, signals → intents → specs pipeline |
| [02-governance.md](02-governance.md) | Who (human or agent) can read and change what, and how the access matrix and validation gates work |
| [03-skills-and-agents.md](03-skills-and-agents.md) | How agents are defined as versioned Markdown skills and scoped to their operator's checkout |
| [04-knowledge-cicd.md](04-knowledge-cicd.md) | What happens on every commit: convention checks, vectorization, agent actions |
| [05-connections.md](05-connections.md) | How the repository connects to external systems (issue trackers, cloud storage, messaging) |
| [06-tooling-and-sandbox.md](06-tooling-and-sandbox.md) | What a member's local environment looks like and how agent execution is sandboxed |
| [07-methodology.md](07-methodology.md) | How work moves through phases and gates on top of the knowledge layer |
| [conventions.md](conventions.md) | Naming, file placement, frontmatter, and formatting rules — the machine-checkable contract |
