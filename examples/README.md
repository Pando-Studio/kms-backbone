# Examples

This directory shows the KMS Backbone conventions applied to one **entirely fictional** project: `acme-project/`, a client engagement by **Acme Studio** (a fictional 8-person digital agency) for **acme-travel**, a client asking for a booking-flow revamp of their travel site.

Every file here is invented for illustration. Any resemblance to a real company, person, or project is coincidental.

## What it demonstrates

One full pipeline cycle, from raw observation to gate decision:

```
1.signals/  →  2.intents/  →  3.specs/  →  meetings/ (gate)
raw inputs     what & why      how           decision recorded
```

## Reading order

1. `acme-project/README.md` — the project card (type, phase, status)
2. `acme-project/1.signals/2026-05-04-kickoff-meeting-transcript.md` — raw client input
3. `acme-project/1.signals/2026-05-06-analytics-export-notes.md` — raw quantitative input
4. `acme-project/2.intents/booking-funnel-revamp.md` — the decision distilled from those signals, with traceability links back to each one
5. `acme-project/3.specs/booking-flow/checkout-revamp-spec.md` — the technical spec derived from the intent
6. `acme-project/meetings/2026-05-12-mlp-vote.md` — the Define → Deliver gate artifact

Note the conventions in action: date-first naming for signals and meetings, name-only for living docs, phase as YAML frontmatter, effort sized S/M/L (never time), and every intent claim referencing its source signal.
