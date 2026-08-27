---
status: draft            # draft | normative
owner: <core-team-group>  # e.g. core-team@acme.example
---

# Validation gates

> **This file defines who validates what.** It applies identically to human and agent contributions. Change it via pull request, like any artifact — including this one (self-referentiality).

## Default gate (all contributions)

Every change — human or agent, `.md` or code — follows the same loop:

```
proposal (pull request) → automated checks → human review → merge
```

| Step | What happens | Blocking? |
|---|---|---|
| Proposal | PR from a branch or fork; direct pushes to `main` are disabled everywhere | — |
| Automated checks | Convention checks (naming, structure), CI, optional agent pre-review | yes |
| Human review | An eligible reviewer (table below) approves | yes |
| Merge | The approver (or the author, after approval) merges; the merge is the dated, attributed decision | — |

## Who validates what (by sensitivity)

<!-- Adjust reviewer groups and counts to your organization. Defaults below are sensible starting points. -->

| Target repository | Author is human | Author is an agent |
|---|---|---|
| S1 (guides, conventions) | 1 core-team reviewer | 1 core-team reviewer |
| S2 (project repos) | 1 reviewer from the project group (core-team for structural changes) | 1 human from the project group |
| S3 (strategy, finance, governance) | 1 core-team reviewer other than the author | 1 core-team reviewer — **no exceptions** |
| `governance/access-matrix.md` | 2 core-team reviewers | 2 core-team reviewers |
| This file (`gates.md`) | 2 core-team reviewers | 2 core-team reviewers |

## Agent contribution rules (defaults — adapt, don't delete)

1. **Label agent PRs.** Every PR authored by an agent carries an `agent` label and names the skill(s) used and the operator or runtime identity that launched it.
2. **An agent never merges.** Agents open PRs; only humans approve and merge. The agent is at most *Responsible*; a human is always *Accountable*.
3. **An agent never self-reviews.** An agent pre-review may run as an automated check, but it never counts as the human approval.
4. **S3 changes proposed by agents require core-team approval** — no delegation to project groups.
5. **Governance files are never merged on agent proposal alone**: an agent may draft a matrix or gates change, but the PR description must state the human intent behind it.
6. **Runaway rule**: if an agent opens repeated failing or conflicting PRs, any member may close them and disable the triggering skill; record the incident as a signal.

## Escalation

<!-- Name your arbitration rule. Keep it to one line if you can. -->

- Disagreement on a review → discussion in the core team; **<named-role-or-pair>** arbitrates; if arbitration ties, **<final-arbiter-role>** has the final call.
- A member (any tier) may challenge an access denial or a rejected PR: file it as a signal in the governance repository; it must be answered by the next periodic audit at the latest.
- Emergency (leaked secret, harmful merge): any core-team member acts immediately (revert, revoke) and records the decision afterward.

## Periodic audit gate

Every `<quarter | month>`:

- [ ] Drift reports reviewed (git-host state vs [access-matrix.md](access-matrix.md))
- [ ] S3 exceptions re-justified or closed
- [ ] Dormant accounts and individual grants purged
- [ ] Agent PR labels and merge rules spot-checked
- [ ] Audit note committed; corrective PRs opened

## How to fill this in

1. Replace group names and reviewer counts with your own; keep the invariant that **a human is always accountable**.
2. Fill the escalation roles.
3. Set `status: normative` and enforce the reviewer rules via your git host's branch protection / code-owner mechanisms where possible.
