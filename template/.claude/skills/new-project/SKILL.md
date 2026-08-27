Create a new project folder in the KMS.

Reference: the KMS Backbone docs (docs/ in the backbone repo) — project grammar and APE phases.

Ask the user for:
1. Project name (will be the folder name)
2. Type: client, prospect, product, r&d, training, or partnership
3. Whether to include APE specs structure (yes/no)
4. Whether it's a programme with sub-projects (yes/no) — if yes, ask for sub-project names (topics)

Then scaffold the following structure:

```
projects/{project-name}/
├── README.md          # Project overview (title, context, objectives, status)
├── 1.signals/         # Raw inputs (feedback, transcriptions, emails, analytics)
├── 2.intents/         # Formalized decisions (briefs, product vision, business cases)
├── 3.specs/           # Technical specs (organized by topic, not by phase)
├── meetings/          # Meeting notes (date-prefixed)
├── admin/             # Contracts, proposals, legal (for client projects)
└── comm/              # Communication, go-to-market
```

If sub-projects were specified, create topic subdirectories inside `3.specs/`:
```
3.specs/
├── {topic-1}/
├── {topic-2}/
└── ...
```

Write the README.md with sections: Context, Objectives, Status, Key contacts, Links.
Follow the language policy in CLAUDE.md. Fill with N/C when information is not provided.
Phases are metadata (YAML frontmatter), NOT directories inside 3.specs/.
