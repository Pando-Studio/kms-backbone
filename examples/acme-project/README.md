---
type: client
phase: deliver
status: active
client: acme-travel
started: 2026-05-04
---

# acme-travel — Booking Flow Revamp

Acme Travel is a mid-size online travel agency whose booking funnel underperforms on mobile: users abandon heavily at the payment step, and support is flooded with tickets about failed card payments. Acme Studio was engaged to revamp the booking flow mobile-first, from search results to confirmation, without touching the inventory or pricing back end.

## Pipeline

| Stage | File | Role |
|---|---|---|
| Signal | [`1.signals/2026-05-04-kickoff-meeting-transcript.md`](1.signals/2026-05-04-kickoff-meeting-transcript.md) | Kickoff meeting — client pain points, verbatim |
| Signal | [`1.signals/2026-05-06-analytics-export-notes.md`](1.signals/2026-05-06-analytics-export-notes.md) | Funnel analytics review — numbers behind the pain |
| Intent | [`2.intents/booking-funnel-revamp.md`](2.intents/booking-funnel-revamp.md) | Decision: rebuild the booking flow mobile-first (what & why) |
| Spec | [`3.specs/booking-flow/checkout-revamp-spec.md`](3.specs/booking-flow/checkout-revamp-spec.md) | Checkout revamp spec (how) |
| Gate | [`meetings/2026-05-12-mlp-vote.md`](meetings/2026-05-12-mlp-vote.md) | MLP vote — Define → Deliver gate decision |

## Current phase status

**Deliver** — the MLP vote on 2026-05-12 approved Option B (rebuild checkout, keep search results as-is). The checkout revamp spec passed review; implementation is underway. Next gate: Readiness Gate before staging.
