# Connections

## One source of truth, synchronized surfaces

The KMS is the source of truth. External tools — issue trackers, cloud storage, chat, the git host itself — are **surfaces**: places where knowledge is displayed, executed, or captured, but never where it authoritatively lives. Every connector therefore declares two things up front: its **sync direction(s)** and its **conflict rule** (who wins when the two sides disagree).

Connectors are implemented as agent skills or CI jobs, not as background daemons. This is deliberate: a sync run started by a skill is a normal contribution — attributable to an operator, previewed before execution, and gated like any other write (see [04-knowledge-cicd.md](04-knowledge-cicd.md)).

## Connector categories

### Project management (Linear/Jira pattern)

- **Direction:** two one-way flows, invoked explicitly. `kms→board` pushes specs to issues: one user story → one issue, acceptance criteria in the description, labels from wave and priority. `board→kms` pulls issue statuses back into a project status doc and detects drift — issues with no corresponding spec, closed issues whose KMS docs were never updated.
- **Conflict rule:** the KMS wins on *content* (what a story says); the board wins on *execution state* (what is in progress or done). The sync skill never silently reconciles — it shows a preview and asks for confirmation before creating or modifying anything.

This is the `sync-issues` skill pattern from [03-skills-and-agents.md](03-skills-and-agents.md).

### Cloud storage for binaries

Markdown lives in git; binaries (PDF, DOCX, images, video) live in cloud storage (Google Drive pattern). The link between the two is a **versioned manifest**: each folder that owns binaries carries a `_files.md` manifest — a table of filename, storage link, last-updated date — committed to git.

- **Direction:** binaries flow to storage; only the manifest flows into git.
- **Conflict rule:** the manifest is authoritative for *which* binaries exist and belong to the folder; storage is authoritative for the bytes. A binary with no manifest entry is untracked knowledge and should be flagged. `.md` files never appear in a manifest — they live in git.

### Communication (Slack/Discord/email)

Chat threads and inboxes are where raw knowledge first appears — and where it evaporates. The connector pattern is **capture, inbound only**: relevant messages, threads, or transcripts are written into a project's `1.signals/` as date-prefixed Markdown files, then processed through the normal pipeline (`process-signals`).

- **Direction:** one-way, tool → KMS.
- **Conflict rule:** none needed; signals are append-only raw material. The KMS never writes back into the conversation surface.

### Git host API (GitHub/GitLab pattern)

The git host is both a surface and part of the enforcement mechanism: PRs implement the gates, and host-side groups implement access.

- **Direction:** PRs and reviews flow through the host's API; group membership is synchronized *from* the identity directory *to* the host, per the versioned access matrix ([02-governance.md](02-governance.md)).
- **Conflict rule:** the access matrix in the repo wins. Host-side permissions that drift from it are corrections waiting to happen; the group-sync job converges the host to the file, never the reverse.

## The governing principle

Every sync is a write to somebody's source of truth. Running connectors as skills or CI jobs — rather than always-on integrations — keeps three properties intact:

1. **Attributable:** each sync run has an operator (or a CI identity) in the log.
2. **Previewed:** skills show what will change and wait for confirmation.
3. **Gated:** anything that lands in the KMS arrives as a commit or PR, subject to the same validation as any contribution.

Credential and transport details (MCP servers, direct APIs) are specified in [../reference/mcp/README.md](../reference/mcp/README.md).
