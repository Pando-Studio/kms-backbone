---
phase: deliver
status: approved
intent: ../../2.intents/booking-funnel-revamp.md
gate: Readiness Gate pending
---

# Spec — Checkout revamp (booking flow)

Implements the [booking-funnel-revamp intent](../../2.intents/booking-funnel-revamp.md). High-level only — no code in specs.

## Approach

Replace the five-screen desktop-era flow with a **three-step mobile-first checkout**: (1) traveler details, (2) review & extras, (3) payment & confirmation. Insurance upsell becomes an inline opt-in on the review step, no longer a dedicated screen. Guest checkout is the default path; account creation is offered post-booking only.

## User stories

| ID | Story | Effort |
|---|---|---|
| US-01 | As a mobile traveler, I complete traveler details on one screen with autofill and inline validation | M |
| US-02 | As a traveler, I book as a guest with only an email address, no account required | S |
| US-03 | As a traveler, I review my trip, toggle extras and insurance inline, and see the final price before paying | M |
| US-04 | As a mobile traveler, I survive a 3-D Secure redirect: my session and cart are restored on return | L |
| US-05 | As a traveler, I pay with Apple Pay or Google Pay in two taps | M |
| US-06 | As a traveler whose payment fails, I see a specific, actionable error message and can retry without re-entering data | S |
| US-07 | As a returning customer, I reuse saved traveler profiles (post-MLP, behind account) | M |

Full INVEST breakdown lives with the story files; this table is the summary of record.

## Architecture decisions (summary)

- **AD-1** — New checkout is a self-contained front-end module talking to existing booking APIs; the inventory/pricing back end is untouched (out-of-scope constraint from the intent).
- **AD-2** — Payment session state is persisted server-side and keyed independently of the browser session, so a 3-D Secure round-trip through a banking app cannot orphan the cart (addresses problem 1).
- **AD-3** — Guest bookings create a lightweight booking record linked to email only; account linkage is an optional post-confirmation step (addresses problem 2).
- **AD-4** — Payment provider error codes are mapped to a curated user-facing message catalogue shared with the support team.

## Acceptance criteria

- Checkout completes in 3 steps on a 375-px viewport with no horizontal scroll.
- Interrupting payment at 3-D Secure and returning within 30 minutes restores the exact cart and step.
- A booking can be completed with zero account interaction.
- Every payment failure path shows a message from the catalogue — the generic fallback appears in < 1% of failures on staging test runs.
- Funnel events instrumented per step so success criteria in the intent are measurable at launch.
