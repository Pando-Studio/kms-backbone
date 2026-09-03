# The ontology audit kit

Goal: produce, BEFORE any KMS installation, the organization's **ontology profile**: its modules, its entity types and their contracts, its vocabularies, its relations, its access tiers. The profile is the deliverable of the audit; the installation (kernel + profile → tree, schemas, skills configuration, CI checks) follows mechanically.

Guiding principle: **you do not design the structure, you reveal it.** The organization already has an ontology; it is implicit, spread across its tools, rituals and heads. The audit makes it explicit and versionable.

---

## 1. Method: 3 steps (about 1 day on site + 1 day of analysis)

| Step | Duration | Activities | Outputs |
|---|---|---|---|
| **A · Immersion** | ½ to 1 day on site | Interviews (grid §2), observation (checklist §3), artifact harvest (§4) | Raw notes, typed artifact corpus |
| **B · Modeling** | ½ to 1 day of analysis | Entity typing, vocabulary extraction, flow mapping, access tiers | Ontology profile v0 + manifest + flow map |
| **C · Restitution** | 2-3 h workshop | Re-read the profile WITH the team: every type, vocabulary and tier is confirmed or corrected by the people who use it | Profile v1, validated + installation plan |

Rule of step C: a vocabulary the team does not recognize is wrong, even if it is logical. The ontology uses the organization's words, never the consultant's.

---

## 2. Interview grid (the questionnaire)

Run with 3 to 5 people in different roles (leadership, operations, admin; 45-60 min each). The sections map to the kernel primitives: signals, knowledge/decisions, stateful dossiers, artifacts, system.

### A · Identity and activity
1. What does the organization do, for whom, and how does it earn its living? (offers, value cycle)
2. What are the 3 to 6 broad domains of activity everyone would recognize? (candidate root modules)
3. What must, five years from now, have left an exploitable trace? (test of what deserves versioning)

### B · Signals: what comes in
4. Through which doors does information enter? (email, meetings, calls, tickets, field work, sensors, monitoring)
5. Who captures what, and where does it end up today? (personal inbox, someone's head, a notebook, a tool)
6. Which signals regularly die without a trace, and which one already cost you dearly by dying?

### C · Decisions: what is authoritative
7. Where are decisions written? If they are not, how does anyone know what was decided?
8. When two sources contradict each other (a document, an email, a memory), which one wins?
9. Which decisions must be replayable/auditable (client, legal, internal)?

### D · Stateful dossiers: the lifecycles
10. Which "dossiers" move through states? (deal, mission, client file, application, project, claim, grant application…) For each:
    - the states, in the team's own words (not ours);
    - the transitions that commit (signature, sending, abandonment) and who may cross them;
    - the "next action": who owns it, where is it written, how does anyone know it is late?
11. Which of these fields change several times a week? (candidates for the fast-lane write whitelist)

### E · Artifacts: what is produced
12. What deliverables are produced? (specs, proposals, contracts, reports, code, materials)
13. For each: engagement level (draft freely rewritten / validated / in production / irreversible) and who validates the move from one level to the next? (candidate gates)
14. Which documents are reused templates? (candidates for the profile's templates)

### F · Vocabularies
15. List the house words: statuses, phases, categories, tags, levels. Which are stable, which are contested?
16. Are there taxonomies imposed from outside? (regulation, certification, funding bodies)

### G · Roles and access
17. Who must see what? Are there access populations that are REALLY distinct today (not in theory: in practice)?
18. What is confidential enough that a leak would be serious? (candidate restricted tier)
19. Must external people (clients, partners, freelancers) access subsets?

### H · Tools in place
20. Inventory: CRM, ERP, Drive/SharePoint, project tool, messaging, accounting. For each: what is authoritative in it today, and what would the team accept to see become a mere downstream target?
21. Which data absolutely must migrate, which can stay where it is?

### I · Rhythms
22. Which rituals exist? (weekly, monthly reporting, follow-ups, closings): candidate crons/agents.
23. What should happen regularly and never does?

### J · Success
24. Six months in, how will you SEE that the KMS works? (a question finally answered fast, a failure that stops repeating)
25. Who will be the daily operator, and how comfortable are they with git/markdown/agents? (calibrates training and the automation share)

---

## 3. Observation checklist (during the on-site day)

- Follow ONE real dossier end to end (from incoming signal to delivered artifact): note every tool crossed, every re-entry, every loss.
- Sit in on one ritual (meeting, pipeline review): note what gets decided and where it lands.
- Open the 3 most-used storage spaces: real folder depth, duplicates, spontaneous naming conventions (they reveal the lived ontology).
- Spot the "spreadsheets of shame": any hand-maintained spreadsheet tracking states is an entity type begging for a contract.

## 4. Artifact harvest

Collect 10 to 15 representative documents (a proposal, minutes, a contract, a report, a decisive email…). For each, type it: which primitive (signal / intent / spec / artifact), which parent dossier, which vocabulary it uses, which engagement level. This corpus validates (or invalidates) the profile in step B.

---

## 5. Audit deliverables

1. **The ontology profile**: root modules (named in the organization's language), entity types + frontmatter contracts (required fields, enumerations), validated vocabularies, relations, sensitivity tier per module, fast-lane whitelist of frequently-updated fields.
2. **The manifest**: mapping modules → profile, with assumed deviations.
3. **The flow map**: incoming signals → dossiers → artifacts, with existing tools positioned as source or downstream target.
4. **The installation plan**: what is generated (tree, schemas, skills, checks), what is migrated, what stays in existing tools, the operator's training.

Exit criterion: the team reads the profile and says "that's us". Not "that's neat".

---

## 6. Audit anti-patterns (pin these to the wall)

- **Imposing our words**: if the team says "case" and not "deal", the type is called case.
- **Over-typing**: an entity type without at least 5 real expected instances in year one does not exist yet; a catch-all `note` type is legal.
- **Partitioning too early**: declaring sensitivity tiers, yes; splitting into sub-repositories before a second real access population exists, no.
- **Modeling the wish**: the ontology describes the organization as it operates, plus one improvement step at most (not three).
- **Forgetting the operator**: a KMS without a daily human who merges is a dead repository; question 25 is eliminatory.
