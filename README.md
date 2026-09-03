# KMS Backbone

**A versioned knowledge backbone for organizations where humans and AI agents work on the same knowledge.**

> The repository is the policy.

Organizations are handing entire functions to AI agents. The question is no longer "is the agent capable?" but "how does an organization give agents access to its knowledge — safely, traceably, governed?" The building blocks all exist — agent memory in Git and Markdown, execution control, access-filtered retrieval — but as isolated pieces. This repository is the assembly: a monorepo of Markdown, shared by humans and agents, where the structure of the repository itself carries the governance.

## The four bricks

1. **Governance by partition** — sub-repositories by sensitivity level; what you can clone is what you can know. No separate permission layer for agents: filesystem access = knowledge access = agent access. The access policy is a versioned file inside the system it governs.
2. **One gate for everyone** — human or agent, every contribution goes proposal (PR) → automated checks → human validation → merge. Agents produce; humans stay accountable.
3. **CI/CD of knowledge** — every commit runs convention checks, re-vectorizes the modified corpus, and triggers agent actions. Semantic search inherits permissions *by construction*: the index is computed per repository, so retrieval never crosses an access boundary.
4. **Provenance by git** — one source of truth; every claim has a dated, attributed history; any prior state is reproducible.

Read the full concept in [docs/00-concept.md](docs/00-concept.md) — five minutes.

## What's in the box

| Directory | Contents |
|---|---|
| [`ontology/`](ontology/) | **Start here.** The audit kit to reveal your organization's ontology before installing anything (3-step method, 25-question interview grid, deliverables, anti-patterns), what a profile declares, three worked profile sketches, and the reference tree |
| [`docs/`](docs/) | The full abstraction, one document per layer: knowledge pipeline, governance, skills & agents, CI/CD of knowledge, connections, tooling & sandbox, methodology, conventions |
| [`template/`](template/) | An instantiable KMS skeleton: project grammar, 16 agent skills, lint hooks, CI workflows, governance templates, agent context file |
| [`reference/`](reference/) | Genericized implementations (each marked `spec` or `reference`): vectorization pipeline, MCP connector configs, agent sandbox |
| [`examples/`](examples/) | A fictional project showing one full pipeline cycle: signal → intent → spec → gate decision |

## Quick start

The first question is not "what folders do I create" but "what IS my organization's structure". So:

1. **Run the ontology audit** ([ontology/audit-kit.md](ontology/audit-kit.md)): about one day on site plus one day of analysis. Its output is your organization's **profile**: modules, entity types, vocabularies, access tiers ([ontology/profiles.md](ontology/profiles.md) shows the shape).
2. Read [docs/00-concept.md](docs/00-concept.md), then [docs/conventions.md](docs/conventions.md).
3. Click **Use this template** (or copy `template/`) and instantiate your profile into the reference tree ([ontology/README.md](ontology/README.md)).
4. Open the repository with your agent CLI: `CLAUDE.md` wires the conventions.
5. Create your first dossier from `projects/_template/` (or run `/new-project`), drop a meeting transcript into its `1.signals/`, and run `/process-signals`.

Full instantiation guide: [template/README.md](template/README.md).

## Tech-agnostic by design

Markdown + Git is the whole dependency. The skills ship in Claude Code format but are plain Markdown, adaptable to any agent runtime — and the structure works with no agent tooling at all. Connectors are patterns (MCP/API), not products. Switch models, hosts or vendors without touching your knowledge.

## Who is behind this

Built and operated internally by [Pando Studio](https://pando-studio.com) since October 2025 (1,400+ versioned documents across projects, research and operations). The system is formalized in academic research on the governance of hybrid human-agent organizations (publication in progress — citation to come).

## Professional services

The backbone is free (Apache 2.0). Pando Studio provides audit, implementation and training for organizations adopting it — [pando-studio.com](https://pando-studio.com).

## Contributing

Contributions follow the same gate as everything else: propose a PR, automated checks run, a human validates. See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

[Apache 2.0](LICENSE)
