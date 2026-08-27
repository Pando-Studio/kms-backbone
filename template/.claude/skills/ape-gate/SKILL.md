Check the readiness of an APE phase gate for a project.

Reference: the KMS Backbone docs (docs/ in the backbone repo) — gates and expected artifacts per phase.

The user will provide:
1. Project path (e.g., `projects/acme-app/`)
2. Gate to check: `pre_sale→discovery`, `discovery→define`, `define→deliver`, `deliver→deploy`, or `deploy→communicate`

For each gate, verify the expected artifacts exist and are non-empty.
Also check the pipeline dirs (`1.signals/`, `2.intents/`) for upstream completeness.
Phases are metadata (YAML frontmatter or pipeline convention), not directories in `3.specs/`.

**Pre-sale → Discovery gate (Engagement Accepted):**
- [ ] `1.signals/` has client brief, emails, or meeting notes
- [ ] `2.intents/` has proposal, quote, or commercial proposition
- [ ] Contract or LOI exists in `admin/` or `contract/`

**Discovery → Define gate (Research Review):**
- [ ] `1.signals/` has raw materials (transcripts, feedback, emails)
- [ ] `3.specs/research-report.md` (or equivalent) exists and has content
- [ ] `3.specs/personas.md` (or equivalent) exists with at least 2 personas
- [ ] Key insights are formalized

**Define → Deliver gate (MLP Vote — 70% consensus):**
- [ ] `3.specs/glossary.md` exists and has terms (domain glossary)
- [ ] User stories documented (stories.md or stories/ folder)
- [ ] `3.specs/waves.md` exists with prioritized waves
- [ ] User flows documented
- [ ] MLP scope documented in `2.intents/` (what/why decided)

**Deliver → Deploy gate (Readiness Gate + Staging Review):**
- [ ] `3.specs/architecture.md` exists and has content
- [ ] At least one ADR in `3.specs/adr/`
- [ ] Tasks decomposed
- [ ] Code repository exists (check for submodule in `apps/`)
- [ ] Tests pass, staging accessible

**Deploy → Communicate gate (Go/No-Go):**
- [ ] `3.specs/test-strategy.md` exists
- [ ] Beta feedback collected
- [ ] No P0/P1 open issues (check your issue tracker if available)
- [ ] Go/No-Go criteria met (see the KMS Backbone docs)

**Adversarial review**: at each gate, explicitly look for gaps, contradictions, and missing links between artifacts. Don't just check presence — check coherence.

Output a checklist with status (passed/missing/incomplete) for each item.
Give a readiness score (0-100%). Highlight blockers clearly.
Do NOT auto-create missing files — just report what's missing.
