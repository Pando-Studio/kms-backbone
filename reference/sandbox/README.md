# Agent Sandbox

**Status: `spec`** — reference implementation to come. Patterns for containing agent execution so that every agent output is reviewable before it takes effect.

Context: [docs/06-tooling-and-sandbox.md](../../docs/06-tooling-and-sandbox.md); the gate it feeds is defined in [docs/02-governance.md](../../docs/02-governance.md).

## Isolation unit: one sandbox per agent task

Two interchangeable patterns:

- **Git worktree** — a separate working directory on the operator's machine, attached to the same clone, checked out on a dedicated branch. Cheap, instant, shares the operator's existing checkout scope. Suited to interactive, operator-supervised tasks.
- **Container** — an isolated filesystem with a fresh clone at exactly the repository set the agent is permitted (hub + allowed submodules, per [docs/02-governance.md](../../docs/02-governance.md)). Suited to headless tasks (CI-triggered agent actions, crons).

In both cases the sandbox's filesystem defines the agent's knowledge scope — including which index namespaces it may query ([../vectorization/README.md](../vectorization/README.md)).

## Write containment

- The agent gets write access to **its own branch only** — one branch per task, never the default branch, never another task's branch.
- All output leaves the sandbox as a **pull request** and goes through the standard gate: automated convention checks, then human validation. The agent holds no merge rights; approving and merging is always a human act.
- Parallel tasks get parallel sandboxes; they cannot see or clobber each other's work in progress.
- After merge or abandonment, the worktree/container is destroyed. Nothing durable exists outside the git history.

## Secrets stay out

The sandbox scope contains **no secrets**: no deploy keys, no database or vector-store credentials, no tokens for privileged external actions. The agent may need one credential — a scoped, short-lived token to push its branch and open the PR — and nothing else. Privileged effects (deploy, publish, index writes) are performed by the CI pipeline *after* human merge, using secrets that live only in the runner's secret store. Consequence: a misbehaving agent can propose anything and execute nothing.
