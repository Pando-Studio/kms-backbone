# Ontology: start here

**Before creating a single folder, answer one question: what IS your organization's structure?**

Every organization already has an ontology. It is implicit: scattered across tools, rituals, spreadsheets and heads. Installing a knowledge backbone does not mean designing a structure; it means **revealing** the one that exists, writing it down, and letting the kernel instantiate it. That is why this repository starts here, not with folders.

```
audit  ──→  profile  ──→  instantiation
(reveal)    (declare)     (generate the tree from template/)
```

- **[audit-kit.md](audit-kit.md)**: the method to reveal the ontology: a 3-step process (immersion, modeling, restitution), a 25-question interview grid, an observation checklist, an artifact harvest, deliverables and anti-patterns. Budget: about one day on site plus one day of analysis.
- **[profiles.md](profiles.md)**: what an ontology profile declares, with worked sketches for three organization types (studio/agency, research lab, school).

## Kernel and profile

The backbone splits into an invariant **kernel** and a variable **profile**:

| | Contents |
|---|---|
| **Kernel** (this repo) | Git + Markdown as the source of truth; the knowledge pipeline (`1.signals/ → 2.intents/ → 3.specs/`); one PR gate for humans and agents; append-only journals; derived indexes rebuilt from the files; CI of knowledge |
| **Profile** (yours, output of the audit) | Which top-level modules exist; which entity types are active and their frontmatter contracts; the vocabularies (statuses, phases, tiers) in YOUR organization's words; the sensitivity tier of each module; the whitelist of fast-changing fields |

The same kernel serves a consulting studio, a research lab, a school or an association; only the profile changes. A multi-activity organization composes several profiles in one repository.

## The reference tree (instantiation target)

```
<org>-kms/
├── README.md          # operating manual entry point
├── CLAUDE.md          # agent context: summary + pointers
├── infra/
│   ├── ontology/      # your profile + manifest : DEFINES everything below
│   ├── guides/        # narratives (conventions, guides)
│   └── tooling/       # indexer, lint hooks, scripts
├── <module>/          # one folder per business function, named in YOUR language,
│   └── <dossier>/     #   declared in the manifest ; every lifecycle dossier uses
│       ├── README.md  #   the SAME grammar: state frontmatter + append-only journal
│       ├── 1.signals/ 2.intents/ 3.specs/ meetings/ admin/ comm/
│       └── apps/      #   code only ever as git submodules
├── _archive/
└── private/           # local-only, gitignored
```

Rules that come from operating this system in production, not from theory:

- **No numbering at the root.** Root domains are business functions, not a sequence. Numbering belongs to one place only: the knowledge pipeline inside a dossier, where order IS the semantics.
- **One grammar everywhere.** A deal, a mission, a project and a grant application all read the same way (state frontmatter + journal + pipeline folders). Humans, indexers and agents learn the shape once.
- **A module is NOT a git submodule by default.** The submodule is the unit of ACCESS, not the unit of structure. A module stays a plain folder while everyone reads it under the same rights; it becomes a submodule only when a distinct access population exists (brick 1: filesystem access = knowledge access = agent access). The single always-submodule case is code under `apps/`, which has its own git lifecycle and CI.
- **Declare sensitivity early, partition late.** Every module carries a sensitivity tier in the manifest from day one; the split into sub-repositories happens only when a second real access population arrives. Premature partition is the most common over-engineering; late declaration is the most common security debt.
- **The install is generated, not copied.** Your tree is the output of kernel + profile. Copying another organization's tree imports their superposed profiles into an organization that needs its own.

## Where this fits in the repo

Run the audit ([audit-kit.md](audit-kit.md)) → write your profile ([profiles.md](profiles.md) shows the shape) → instantiate with [`template/`](../template/) → operate with [`docs/`](../docs/) as the narrative reference.
