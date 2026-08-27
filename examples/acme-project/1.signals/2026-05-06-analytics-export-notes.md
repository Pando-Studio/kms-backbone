---
date: 2026-05-06
type: analytics-review
source: client
phase: discovery
---

# Analytics export — booking funnel review notes

> Raw signal. Notes from reviewing the funnel export sent by Priya (Acme Travel) covering 2026-02-01 → 2026-04-30.

## Funnel (all devices, per 100 sessions entering booking)

| Step | Enter | Complete | Drop |
|---|---|---|---|
| 1. Traveler details | 100 | 71 | −29% |
| 2. Extras & insurance | 71 | 58 | −18% |
| 3. Payment | 58 | 31 | **−47%** |
| 4. Confirmation | 31 | 31 | — |

Step 3 (payment) is by far the worst step. Within step 3, ~60% of abandons happen after the 3-D Secure redirect fires (session not recovered on return).

## Device split

- Traffic entering booking: **64% mobile / 36% desktop**.
- End-to-end completion: **11% mobile vs 34% desktop** — a 3× gap.
- Account-creation wall bounces ~1 in 5 mobile users before step 1 even starts (not counted in funnel above).

Matches support data: payment-step tickets = 41% of all tickets last quarter (Ben's export, same period).
