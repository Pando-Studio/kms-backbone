---
status: draft            # draft | normative
owner: <core-team-group>  # group accountable for this policy, e.g. core-team@acme.example
last_audit: N/C           # date of last drift audit
---

# Access matrix — groups × repositories (normative)

> **This file is the policy.** The reconciler reads it, applies it to your git-host teams and repository permissions, and the drift audit flags any divergence between this matrix and reality. **Changing access = a pull request on this file**, reviewed like any other artifact (see [gates.md](gates.md)). The git history of this file is the audit trail.

Legend: `admin` / `write` / `clone` / `–` (no access; the repository is absent from the member's checkout).
"assigned" = only for members holding the matching `prj-<slug>` group.
Agents hold no rows: **an agent inherits the filesystem scope of its operator or runtime identity** — grant access to the human or service group, never to "the AI".

## Matrix

| Repository | Sensitivity | core-team | extended-circle | prj-* groups | service identities (agent runtimes) |
|---|---|---|---|---|---|
| `hub` (root repo, submodule references) | S1 | admin | clone | clone | clone |
| `infra` (guides, conventions, handbook) | S1 | admin | clone | clone | clone |
| `prj-acme-website` | S2 | admin | write (assigned) | write | per runtime scope |
| `prj-acme-mobile-app` | S2 | admin | write (assigned) | write | per runtime scope |
| `prj-<slug>` (one row per project) | S2 | admin | write (assigned) | write | per runtime scope |
| `pre-sale` (pipeline, proposals) | S3 | admin | – | – | S3 runtime only |
| `strategy` | S3 | admin | – | – | – |
| `finance-admin` | S3 | admin | – | – | S3 runtime only |
| `governance` (this folder's home) | S3 | admin | – | – | – |

<!-- Add one row per repository. Delete the acme-* placeholder rows. -->

## Rules

1. **Groups only, never individuals.** Every grant maps to a directory group. A temporary S3 exception = a dedicated group (e.g. `s3-exception-<topic>`) plus a dated decision entry — closed or re-justified at each audit.
2. **Write to S1 is core-team only.** Others propose changes via pull request.
3. **Branch protection everywhere.** `main` is protected on all repositories; non-core contributions land via PR.
4. **Split repositories when the ACL differs**, not when the topic differs.
5. On conflict between this file and any machine-readable companion (e.g. a generated YAML), **this file wins** and the drift audit reports the companion as stale.

## How to fill this in

1. List every repository in your hub's submodule topology; assign each exactly one sensitivity level.
2. Replace the group names with your directory groups; replace `acme-*` rows with your projects.
3. Set `status: normative` once your reconciler starts enforcing it.
4. From then on: never change permissions in the git-host UI directly — open a PR here and let the reconciler apply it.
