---
phase: define
status: validated
sources:
  - ../1.signals/2026-05-04-kickoff-meeting-transcript.md
  - ../1.signals/2026-05-06-analytics-export-notes.md
validated_by: MLP vote 2026-05-12 (see ../meetings/2026-05-12-mlp-vote.md)
---

# Intent — Booking funnel revamp

## Decision (what)

Rebuild the Acme Travel booking flow **mobile-first**, from traveler details through confirmation. Search and results pages are untouched. This document states what we change and why — the how lives in `3.specs/booking-flow/`.

## Why

64% of booking traffic is mobile, yet mobile completes end-to-end at 11% vs 34% on desktop ([analytics 2026-05-06](../1.signals/2026-05-06-analytics-export-notes.md)). The flow was designed desktop-first in 2021 and patched since ([kickoff 2026-05-04](../1.signals/2026-05-04-kickoff-meeting-transcript.md), Marta). Incremental fixes have not moved the numbers; the funnel needs a rebuild.

## Prioritized problems (with evidence)

1. **Payment step loses nearly half its users.** −47% drop at step 3, ~60% of those abandons after the 3-D Secure redirect fails to recover the session on mobile ([analytics 2026-05-06](../1.signals/2026-05-06-analytics-export-notes.md)). Support confirms: payment tickets = 41% of all tickets, top category ([kickoff 2026-05-04](../1.signals/2026-05-04-kickoff-meeting-transcript.md), Ben). Generic "an error occurred" messages amplify the ticket load (same source).

2. **The account-creation wall blocks bookings before they start.** ~1 in 5 mobile users bounce at forced sign-up ([analytics 2026-05-06](../1.signals/2026-05-06-analytics-export-notes.md)); client suspected exactly this ([kickoff 2026-05-04](../1.signals/2026-05-04-kickoff-meeting-transcript.md), Marta: guest checkout is wish #1).

3. **Too many form screens before payment.** Five screens of forms; −29% at traveler details and −18% at the extras/insurance interruption ([analytics 2026-05-06](../1.signals/2026-05-06-analytics-export-notes.md)); "on mobile it feels like filling in a tax form" ([kickoff 2026-05-04](../1.signals/2026-05-04-kickoff-meeting-transcript.md), Marta).

## Success criteria

- Mobile end-to-end completion ≥ 20% within one quarter of launch (baseline 11%).
- Payment-step drop reduced from −47% to ≤ −25%.
- Payment-related support tickets reduced by half (baseline 41% of tickets).
- Guest checkout live; no forced account creation anywhere in the flow.

## Out of scope

- Search and results pages (client-stated, performing fine).
- Anything touching the inventory/pricing back end (separate vendor contract).
- Loyalty programme, multi-currency, B2B group bookings.
