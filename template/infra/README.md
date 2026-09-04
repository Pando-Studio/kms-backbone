# infra/

System documentation lives in the KMS Backbone repo's `docs/` — this folder is for **your org-specific overrides and tooling**.

Put here:
- `ontology/` — **your organization's profile and manifest** (`profile.md`, `manifest.md`): the output of the ontology audit, and the declarative definition of everything else in this repository. Fill these first.
- Conventions that extend or specialize the backbone defaults (naming, language policy details, review rules)
- Org-specific tooling notes (CI wiring, sync scripts, integrations)

Do not fork the backbone docs into this folder — reference them, and only document your deltas.
