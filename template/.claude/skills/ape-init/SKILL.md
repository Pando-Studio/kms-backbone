Initialize the APE (Adaptive Product Engineering) phase structure for a project.

Reference: the KMS Backbone docs (docs/ in the backbone repo) — phases, gates, toolkits per phase.

The user will provide a project path (e.g., `projects/acme-app/` or `projects/acme-travel/`). If not provided, ask for it.

Also scaffold `1.signals/`, `2.intents/`, and `meetings/` if they don't exist yet.

Scaffold the APE specs structure inside the project folder. Phases are metadata (YAML frontmatter), NOT directories:

```
{project}/
├── 1.signals/                # Raw inputs (create if missing)
├── 2.intents/                # Decisions (create if missing)
├── meetings/                 # Meeting notes (create if missing)
└── 3.specs/
    ├── research-report.md    # phase: discovery — Market context, Methodology, Key findings
    ├── personas.md           # phase: discovery — Name, Role, Goals, Pain points, Behaviors
    ├── glossary.md           # phase: define — Domain glossary (Term, Definition, Context, Rules)
    ├── stories.md            # phase: define — User stories (As a... I want... So that...)
    ├── waves.md              # phase: define — Wave planning (Wave, Stories, Dependencies, Status)
    ├── architecture.md       # phase: deliver — Tech stack, System overview, Key decisions, C4
    ├── adr/                  # phase: deliver — Architecture Decision Records
    ├── tasks.md              # phase: deliver — Task breakdowns + execution briefs
    └── test-strategy.md      # phase: deploy — Test levels, Beta stages, Tools
```

Each template file should have:
- YAML frontmatter with `phase: {phase_name}`
- A title and purpose description
- The expected structure with placeholder sections
- A reference: "See the KMS Backbone docs for toolkit details"

Write templates in English (dev tasks). Do NOT fill with fake data — use N/C or placeholder text.
